public inherited sharing class SObjSort {
    
    /**
     * sorts ascendingly
     */

    public static Sorter ascending(SObjectField field) {
        return new Sorter(new SortParam(field, Direction.ASCENDING));
    }

    public static Sorter ascending(SObjectField relationshipField, SObjectField parentField) {
        return new Sorter(new SortParam(relationshipField, parentField, Direction.ASCENDING));
    }

    /**
     * sorts descendingly
     */

    public static Sorter descending(SObjectField field) {
        return new Sorter(new SortParam(field, Direction.DESCENDING));
    }

    public static Sorter descending(SObjectField relationshipField, SObjectField parentField) {
        return new Sorter(new SortParam(relationshipField, parentField, Direction.DESCENDING));
    }

    /**
     * holds sort params and executes sorting
     */

    public class Sorter {
        private final List<SortParam> sortParams = new List<SortParam>();

        private Sorter(SortParam sortParam) {
            this.sortParams.add(sortParam);
        }
        
        /**
         * sorts by another field ascendingly
         */

        public Sorter ascending(SObjectField field) {
            this.sortParams.add(new SortParam(field, Direction.ASCENDING));
            return this;
        }

        public Sorter ascending(SObjectField field, SObjectField parentField) {
            this.sortParams.add(new SortParam(field, parentField, Direction.ASCENDING));
            return this;
        }

        /**
         * sorts by another field descendingly
         */
    
        public Sorter descending(SObjectField field) {
            this.sortParams.add(new SortParam(field, Direction.DESCENDING));
            return this;
        }

        public Sorter descending(SObjectField field, SObjectField parentField) {
            this.sortParams.add(new SortParam(field, parentField, Direction.DESCENDING));
            return this;
        }

        /**
         * executes sorting and returns first record
         */

        public SObject sortTakeFirst(List<SObject> sObjs) {
            return sObjs != null && ! sObjs.isEmpty() ? this.sort(sObjs)[0] : null;
        }

        /**
         * executes sorting and returns last record
         */

        public SObject sortTakeLast(List<SObject> sObjs) {
            if(sObjs == null || sObjs.isEmpty()) {
                return null;
            }

            List<SObject> sortedSObjs = this.sort(sObjs);
            return sortedSObjs[sortedSObjs.size()-1];
        }

        /**
         * executes sorting and returns n records from the beginning of the list
         */

        public List<SObject> sortTakeN(List<SObject> sObjs, Integer n) {
            if(sObjs == null || sObjs.isEmpty()) {
                return new List<SObject>();
            }

            if(n <= 0) {
                throw new SObjSException('n must be greater than 0');
            }

            List<SObject> sortedSObjs = new List<SObject>();
            for(SObject sObj : this.sort(sObjs)) {
                if(sortedSObjs.size() == n) {
                    break;
                }
                
                sortedSObjs.add(sObj);
            }

            return sortedSObjs;
        }

        /**
         * executes sorting and returns all records
         */

        public List<SObject> sort(List<SObject> sObjs) {
            if(sObjs == null || sObjs.isEmpty()) {
                return new List<SObject>();
            }

            List<SObject> sortedSObjs = sObjs;

            for(SortParam sortParam : this.sortParams) {
                List<Sortable> sortables = this.buildSortables(sortedSObjs, sortParam);
                sortables.sort();
                sortedSObjs = new List<SObject>();

                for(Sortable sortable : sortables) {
                    sortedSObjs.add(sortable.sObj);
                }
            }

            return sortedSObjs;
        }

        private List<Sortable> buildSortables(List<SObject> sObjs, SortParam sortParam) {
            List<Sortable> sortables = new List<Sortable>();
            DisplayType fieldType = sortParam.parentField != null 
                                        ? sortParam.parentField.getDescribe().getType() 
                                        : sortParam.field.getDescribe().getType();
            Type sortableType = FIELD_TYPE_SORTABLE_MAPPING.get(fieldType);

            if(sortableType == null) {
                throw new SObjSException('sorting this field type is not supported => '+ fieldType);
            }

            for(SObject sObj : sObjs) {
                Sortable sortable = (Sortable) sortableType.newInstance();
                sortables.add(sortable.setFields(sortParam, sObj));
            }

            return sortables;
        }
    }

    /**
     * holds mapping of field type to sorter implementation
     */

    private static Map<DisplayType, Type> FIELD_TYPE_SORTABLE_MAPPING = new Map<DisplayType, Type> {
        DisplayType.INTEGER => DecimalSortable.class,
        DisplayType.DOUBLE => DecimalSortable.class,
        DisplayType.PERCENT => DecimalSortable.class,
        DisplayType.CURRENCY => DecimalSortable.class,
        DisplayType.DATE => DatetimeSortable.class,
        DisplayType.DATETIME => DatetimeSortable.class,
        DisplayType.TIME => DatetimeSortable.class,
        DisplayType.STRING => StringSortable.class,
        DisplayType.EMAIL => StringSortable.class,
        DisplayType.PHONE => StringSortable.class,
        DisplayType.URL => StringSortable.class
    };

    private enum Direction { ASCENDING, DESCENDING }

    /**
     * data class holding parameters needed for sorting
     */

    private class SortParam {
        private final SObjectField field;
        private final SObjectField parentField;
        private final Direction direction;
        private final String relationshipField;

        private SortParam(SObjectField field, Direction direction) {
            if(field == null) {
                throw new SObjSException('field cannot be null');
            }

            this.field = field;
            this.direction = direction;
        }

        private SortParam(SObjectField field, SObjectField parentField, Direction direction) {
            this(field, direction);
            this.parentField = parentField;
            this.relationshipField = field.getDescribe().getRelationshipName();
        }
    }

    /**
     * base class for all sorter implementations
     */

    private abstract class Sortable implements Comparable {
        private SortParam sortParam;
        public SObject sObj { public get; private set; }
        private Boolean sortedByParendField;

        public Sortable() { }

        public Sortable setFields(SortParam sortParam, SObject sObj) {
            this.sortParam = sortParam;
            this.sObj = sObj;
            this.sortedByParendField = sortParam.parentField != null;
            return this;
        }

        public Object getValue() {
            return this.sortedByParendField
                        ? this.sObj.getSObject(this.sortParam.relationshipField).get(this.sortParam.parentField)
                        : this.sObj.get(this.sortParam.field);
        }
    }

    /**
     * sortable for number fields
     */

    private class DecimalSortable extends Sortable {
        public DecimalSortable() {
            super();
        }

        public Integer compareTo(Object otherSortable){
            Decimal val1 = (Decimal) this.getValue();
            Decimal val2 = (Decimal) ((Sortable) otherSortable).getValue();
            Integer res = 0;

            switch on this.sortParam.direction {
                when ASCENDING {
                    if(val1 == null) { res = 1; }
                    else if(val2 == null) { res = -1; }
                    else if(val1 > val2) { res = 1; }
                    else if(val1 < val2) { res = -1; }
                }
                when DESCENDING {
                    if(val1 == null) { res = 1; }
                    else if(val2 == null) { res = -1; }
                    else if(val1 > val2) { res = -1; }
                    else if(val1 < val2) { res = 1; }
                }
            }

            return res;
        }
    }

    /**
     * sortable for time and date/-time fields
     */

    private class DatetimeSortable extends Sortable {
        public DatetimeSortable() {
            super();
        }

        public Integer compareTo(Object otherSortable){
            Datetime val1;
            Datetime val2;
            Object objVal1 = this.getValue();
            Object objVal2 = ((Sortable) otherSortable).getValue();

            if(DisplayType.TIME == this.sortParam.field.getDescribe().getType()) {
                val1 = objVal1 != null ? Datetime.newInstance(Date.today(), (Time) objVal1) : null;
                val2 = objVal2 != null ? Datetime.newInstance(Date.today(), (Time) objVal2) : null;
            }
            else {
                val1 = (Datetime) objVal1;
                val2 = (Datetime) objVal2;
            }

            Integer res = 0;

            switch on this.sortParam.direction {
                when ASCENDING {
                    if(val1 == null) { res = 1; }
                    else if(val2 == null) { res = -1; }
                    else if(val1 > val2) { res = 1; }
                    else if(val1 < val2) { res = -1; }
                }
                when DESCENDING {
                    if(val1 == null) { res = 1; }
                    else if(val2 == null) { res = -1; }
                    else if(val1 > val2) { res = -1; }
                    else if(val1 < val2) { res = 1; }
                }
            }

            return res;
        }
    }

    /**
     * sortable for string fields
     */

    private class StringSortable extends Sortable {
        public StringSortable() {
            super();
        }

        public Integer compareTo(Object otherSortable){
            String val1 = (String) this.getValue();
            String val2 = (String) ((Sortable) otherSortable).getValue();
            Integer res = 0;

            switch on this.sortParam.direction {
                when ASCENDING {
                    if(val1 == null) { res = 1; }
                    else if(val2 == null) { res = -1; }
                    else if(val1 > val2) { res = 1; }
                    else if(val1 < val2) { res = -1; }
                }
                when DESCENDING {
                    if(val1 == null) { res = 1; }
                    else if(val2 == null) { res = -1; }
                    else if(val1 > val2) { res = -1; }
                    else if(val1 < val2) { res = 1; }
                }
            }

            return res;
        }
    }

    public class SObjSException extends Exception { }
}