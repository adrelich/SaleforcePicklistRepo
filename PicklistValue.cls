public with sharing class PicklistValue {

    public String label { get; private set; }
    public String value { get; private set; }

    public PicklistValue(String label, String value) {
        this.label = label;
        this.value = value;
    }
}
