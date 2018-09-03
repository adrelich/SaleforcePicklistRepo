public with sharing class PicklistRepository {

    private Map<String, PicklistBuilder> builderRepository;

    public PicklistRepository() {
        builderRepository = new Map<String, PicklistBuilder>();
    }

    public PicklistRepository addPickListBuilder(String keyString, PicklistBuilder picklistBuilderImpl) {
        if (!builderRepository.containsKey(keyString)) {
            builderRepository.put(keyString, picklistBuilderImpl);
            return this;
        }
        throw new PicklistRepositoryException('This key already exists', 1);
    }

    public PicklistConfiguration buildOncePickList(String keyString) {
        if (builderRepository.containsKey(keyString)) {
            return builderRepository.get(keyString).buildPicklist();
        }
        throw new PicklistRepositoryException(String.format('{0} Builder not exists', new List<String>{
                keyString
        }), 1);
    }

    public Map<String, PicklistConfiguration> buildAllPicklist() {
        Map<String, PicklistConfiguration> returnMap = new Map<String, PicklistConfiguration>();
        for (String keyString : builderRepository.keySet()) {
            returnMap.put(keyString, builderRepository.get(keyString).buildPicklist());
        }
        return returnMap;
    }
}