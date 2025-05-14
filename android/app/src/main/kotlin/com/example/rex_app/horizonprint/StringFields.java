//package com.example.rex_app.horizonprint;
//
//import androidx.annotation.Keep;
//
//import java.io.Serializable;
//
//@Keep
//public class StringFields implements Serializable {
//    private boolean isMultiline;
//    private TextField header;
//    private TextField body;
//
//    public StringFields() {
//    }
//
//    private StringFields(TextField header) {
//        this.isMultiline = true;
//        this.header = header;
//        this.body = new TextField("");
//    }
//
//    private StringFields(TextField header, TextField body) {
//        this.isMultiline = false;
//        this.header = header;
//        this.body = body;
//    }
//
//    public boolean isMultiline() {
//        return isMultiline;
//    }
//
//    public void setMultiline(boolean multiline) {
//        isMultiline = multiline;
//    }
//
//    public TextField getHeader() {
//        return header;
//    }
//
//    public void setHeader(TextField header) {
//        this.header = header;
//    }
//
//    public TextField getBody() {
//        return body;
//    }
//
//    public void setBody(TextField body) {
//        this.body = body;
//    }
//
//    public static StringFields headerField(String header) {
//        if (header != null && !header.isEmpty()) {
//            return new StringFields(new TextField(header, true));
//        } else {
//            return new StringFields(new TextField(""));
//        }
//    }
//
//    public static StringFields footerField(String footer) {
//        if (footer != null && !footer.isEmpty()) {
//            return new StringFields(new TextField(footer, false));
//        } else {
//            return new StringFields(new TextField(""));
//        }
//    }
//
//    public static StringFields labelValueField(String label, String value) {
//        if (value != null && !value.isEmpty()) {
//            return new StringFields(new TextField(label, PrintAlignment.left), new TextField(value));
//        } else {
//            return new StringFields(new TextField(label, PrintAlignment.left), new TextField(""));
//        }
//    }
//}
