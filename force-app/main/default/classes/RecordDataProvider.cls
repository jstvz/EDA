/*
    This example apex class provides details for populating views that display a record.
    For the methods that return a single sobject directly, see usage defined in 'view_contact', 'view_account', and 'view_opportunity.'
    For the method that returns data in a list for an iterator, see usage in 'record_detail_message.'
*/
public class RecordDataProvider {
    /*public static List<FieldData> getRecord(String recordId, String objectApiName) {
        Sobject record;

        record = getContactById(recordId);

        Map<String, Object> fields = record.getPopulatedFieldsAsMap();
        List<FieldData> fieldsList = new List<FieldData>();
        for (String key : fields.keySet()) {
            FieldData fieldData = new FieldData(key, fields.get(key));
            fieldsList.add(fieldData);
        }

        return fieldsList;
    }*/

    public static List<Contact> getContactById(String contactName) {
        List<Contact> contacts = [SELECT Name, Id, Title, Phone, Email FROM Contact WHERE Name = :contactName];

        return contacts;
    }
}
