public with sharing class PicklistBuilderSalesforceObject implements PicklistBuilder {

    private SObjectType objectType;
    private String fieldName;

    public PicklistBuilderSalesforceObject(SObjectType objectType, String fieldName) {
        this.objectType = objectType;
        this.fieldName = fieldName;
    }

    public PicklistConfiguration buildPicklist() {
        PicklistConfiguration resultValues = new PicklistConfiguration();
        Map<String, Schema.SObjectField> fieldDescribe = objectType.getDescribe().fields.getMap();
        if (fieldDescribe.containsKey(this.fieldName)) {
            List<Schema.PicklistEntry> pickListValue = fieldDescribe.get(this.fieldName).getDescribe().getPickListValues();
            for (Schema.PicklistEntry item : pickListValue) {
                resultValues.picklistValues.add(new PicklistValue(item.getLabel(), item.getValue()));
            }
            return resultValues;
        }
        throw new PicklistRepositoryException(String.format('Field {0} do not exists in {1} object', new List<String>{
                this.fieldName, this.objectType.getDescribe().name
        }), 1);
    }
}