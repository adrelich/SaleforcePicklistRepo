@IsTest
public with sharing class PicklistRepositoryTest {

    @IsTest
    public static void ShouldReturnSinglePicklistConfigurationFromSalesforceObject() {
        PicklistConfiguration picklistConfiguration = new PicklistRepository().addPickListBuilder('OpportunityStagePicklist', new PicklistBuilderSalesforceObject(
                Opportunity.SObjectType, 'StageName'
        )).buildOncePickList('OpportunityStagePicklist');
        System.assert(picklistConfiguration != null);
        System.assert(picklistConfiguration.picklistValues.size() > 0);
    }

    @IsTest
    public static void ShouldReturnListOfPicklistConfiguration() {
        Map<String, PicklistConfiguration> picklistConfigurationMap = new PicklistRepository().addPickListBuilder('OpportunityStagePicklist', new PicklistBuilderSalesforceObject(
                Opportunity.SObjectType, 'StageName'
        )).buildAllPicklist();
        System.assert(picklistConfigurationMap != null);
        System.assert(picklistConfigurationMap.size() > 0);
    }

    @IsTest
    public static void ShouldThrowExceptionFieldNameDontExists() {
        try {
            Map<String, PicklistConfiguration> picklistConfigurationMap = new PicklistRepository().addPickListBuilder('OpportunityStagePicklist', new PicklistBuilderSalesforceObject(
                    Opportunity.SObjectType, 'StageName2'
            )).buildAllPicklist();
            System.assert(false);
        } catch (Exception ex) {
            System.assert(true);
        }
    }

    @IsTest
    public static void ShouldThrowExceptionAboutBuilderDontExists() {
        try {
            PicklistConfiguration picklistConfiguration = new PicklistRepository().buildOncePickList('OpportunityStageName');
            System.assert(false);
        } catch (PicklistRepositoryException ex) {
            System.assertEquals('OpportunityStageName Builder not exists', ex.message);
        }
    }

    @IsTest
    public static void ShouldThrowExceptionDuplicateBuilder() {
        try {
            Map<String, PicklistConfiguration> picklistConfigurationMap = new PicklistRepository()
                    .addPickListBuilder('OpportunityStagePicklist', new PicklistBuilderSalesforceObject(Opportunity.SObjectType, 'StageName'))
                    .addPickListBuilder('OpportunityStagePicklist', new PicklistBuilderSalesforceObject(Opportunity.SObjectType, 'StageName'))
                    .buildAllPicklist();
            System.assert(false);
        } catch (Exception ex) {
            System.assert(true);
        }
    }
}