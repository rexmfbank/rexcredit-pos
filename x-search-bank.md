# Search Bank Feature — Implementation Guide

## Problem

The `BankList` widget has a "Search Bank" text field (`RexSearchField`) that currently does nothing. The `onChanged` callback is commented out, and the notifier's `filterBanks` method is also commented out. We need to:

1. Let the user type a query and **filter the displayed bank list** (case-insensitive).
2. Show a **"Not available"** message when no banks match the query.
3. **Restore** the full list when the user clears the search field.
4. Keep all filtering logic inside the **notifier & state** (not in the widget).

---

## How It Works (Concept)

The API returns the full bank list once via `getBanksList()`. We store that list in a new field called `allBanks` (the **master copy**). The existing `banksList` becomes the **display list** — it always reflects whatever the user should currently see (filtered or unfiltered).

When the user types into the search field:
- The widget calls `notifier.filterBanks(query)`.
- The notifier filters `allBanks` by checking if each bank's `name` **contains** the query (case-insensitive).
- The result is written to `banksList` via `copyWith`.
- When the query is empty, `banksList` is reset to `allBanks`.

The widget reads `state.banksList` and renders accordingly — if it's empty, it shows "Not available".

---

## Changes Required (3 files)

---

### 1. State — `transfer_ext_state.dart`

**What changes:** Add a new field `allBanks` to hold the unfiltered master list.

#### Add the field to the class

```dart
class TransferExtState extends Equatable {
  // ... existing fields ...
  final List<BankData> banksList;
  final List<BankData> allBanks;        // <-- ADD THIS
  // ...
```

#### Add it to the constructor

```dart
  const TransferExtState({
    // ... existing params ...
    required this.banksList,
    required this.allBanks,             // <-- ADD THIS
    // ...
  });
```

#### Add it to `copyWith`

In the **parameter list**:

```dart
  TransferExtState copyWith({
    // ... existing params ...
    List<BankData>? banksList,
    List<BankData>? allBanks,           // <-- ADD THIS
    // ...
  }) => TransferExtState(
    // ... existing assignments ...
    banksList: banksList ?? this.banksList,
    allBanks: allBanks ?? this.allBanks, // <-- ADD THIS
    // ...
  );
```

#### Add it to `props`

```dart
  @override
  List<Object?> get props => [
    // ... existing props ...
    banksList,
    allBanks,                           // <-- ADD THIS
    // ...
  ];
```

---

### 2. Notifier — `transfer_ext_provider.dart`

**What changes:**
- Initialize `allBanks: []` in `build()`.
- Save the API result to **both** `allBanks` and `banksList` in `getBanksList()`.
- Uncomment and rewrite `filterBanks()`.
- Update `clearBankSearch()` to also reset the displayed list.

#### A) In `build()` — add `allBanks`

```dart
  @override
  TransferExtState build() {
    ref.onDispose(() => _dispose());
    return TransferExtState(
      // ... existing fields ...
      banksList: [],
      allBanks: [],                     // <-- ADD THIS
      // ...
    );
  }
```

#### B) In `getBanksList()` — store to both lists

Replace the `state.copyWith` inside the `try` block:

```dart
  Future<void> getBanksList() async {
    state = state.copyWith(fetchingBanks: true);
    final config = AppKeysStorage.getConfig();
    final header = HeaderWithAuthNoCrypt(
      appVersion: config.appVersionLocal,
      deviceID: config.serialNumber,
      authToken: config.loginAuthToken,
      geoLong: config.longitude,
      geoLat: config.latitude,
    );
    try {
      final res = await RexApi.instance.bankList(header: header);
      state = state.copyWith(
        fetchingBanks: false,
        banksList: res,
        allBanks: res,                   // <-- ADD THIS
      );
    } catch (err, _) {
      debugPrintDev("error getting banks list $err");
    }
  }
```

#### C) Uncomment & rewrite `filterBanks()`

Remove the commented-out block (lines 163–181) and replace with:

```dart
  void filterBanks(String query) {
    if (query.isEmpty) {
      // Reset to the full list
      state = state.copyWith(banksList: state.allBanks);
      return;
    }

    final input = query.toLowerCase();
    final filtered = state.allBanks.where((bank) {
      final bankName = (bank.name ?? '').toLowerCase();
      return bankName.contains(input);
    }).toList();

    state = state.copyWith(banksList: filtered);
  }
```

#### D) Update `clearBankSearch()`

Replace the current `clearBankSearch()` (lines 158–161) with:

```dart
  void clearBankSearch() {
    state = state.copyWith(
      bankSearchController: TextEditingController(),
      banksList: state.allBanks,         // <-- reset the displayed list
    );
  }
```

This ensures that when the bottom sheet is closed and reopened, the full list is visible again.

---

### 3. Widget — `bank_list.dart`

**What changes:**
- Wire up the `onChanged` callback to call `filterBanks`.
- Show a "Not available" message when the filtered list is empty and we're not loading.

#### A) Uncomment the `onChanged` callback (line 56)

Replace:

```dart
  onChanged: (value) {
    //ref.watch(transferExtProvider.notifier).filterBanks(value);
  },
```

With:

```dart
  onChanged: (value) {
    ref.read(transferExtProvider.notifier).filterBanks(value);
  },
```

> **Important:** Use `ref.read` here, not `ref.watch`. The original commented code used `ref.watch` which is incorrect inside a callback — `ref.watch` should only be used inside `build()`.

#### B) Handle the empty list state

Replace the current list rendering block (lines 66–79):

```dart
  state.fetchingBanks
      ? Center(child: CupertinoActivityIndicator(radius: 24))
      : Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 2.ah),
            itemCount: state.banksList.length,
            itemBuilder: (context, index) {
              return BankListItem(
                bankData: state.banksList[index],
                onTap: () => widget.onClick.call(state.banksList[index]),
              );
            },
          ),
        ),
```

With:

```dart
  state.fetchingBanks
      ? Center(child: CupertinoActivityIndicator(radius: 24))
      : state.banksList.isEmpty
          ? Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 40.ah),
                  child: Text(
                    'Not available',
                    style: AppTextStyles.body2Regular.copyWith(
                      color: AppColors.rexTint500,
                    ),
                  ),
                ),
              ),
            )
          : Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 2.ah),
                itemCount: state.banksList.length,
                itemBuilder: (context, index) {
                  return BankListItem(
                    bankData: state.banksList[index],
                    onTap: () => widget.onClick.call(state.banksList[index]),
                  );
                },
              ),
            ),
```

---

## Data Flow

```
User types "zenith"
       │
       ▼
onChanged(value)  ──►  notifier.filterBanks("zenith")
                              │
                              ▼
                   allBanks.where(name.contains("zenith"))
                              │
                              ▼
                   state = state.copyWith(banksList: filtered)
                              │
                              ▼
                   Widget rebuilds → shows filtered list
                              │
                   (if filtered is empty → shows "Not available")


User clears field (empty string)
       │
       ▼
onChanged("")  ──►  notifier.filterBanks("")
                              │
                              ▼
                   state = state.copyWith(banksList: allBanks)
                              │
                              ▼
                   Widget rebuilds → shows full list


User selects a bank
       │
       ▼
onClick(bankData)  ──►  notifier sets bank info + calls clearBankSearch()
                              │
                              ▼
                   bankSearchController reset + banksList = allBanks
                              │
                              ▼
                   Bottom sheet closes, list ready for next open
```

---

## Summary of All Changes

| File | Change | Purpose |
|------|--------|---------|
| `transfer_ext_state.dart` | Add `allBanks` field + constructor + `copyWith` + `props` | Store the unfiltered master bank list |
| `transfer_ext_provider.dart` | Add `allBanks: []` in `build()` | Initialize the new field |
| `transfer_ext_provider.dart` | Update `getBanksList()` to set both `banksList` and `allBanks` | Populate master list from API |
| `transfer_ext_provider.dart` | Add `filterBanks(String query)` method | Case-insensitive filter logic |
| `transfer_ext_provider.dart` | Update `clearBankSearch()` to reset `banksList` to `allBanks` | Restore full list on clear |
| `bank_list.dart` | Wire `onChanged` → `filterBanks(value)` using `ref.read` | Connect search field to notifier |
| `bank_list.dart` | Add empty-state check → "Not available" text | UX feedback when no results match |
