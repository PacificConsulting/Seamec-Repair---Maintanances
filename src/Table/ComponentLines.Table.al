table 50000 "Component Lines"
{
    DrillDownPageID = 50006;
    LookupPageID = 50006;

    fields
    {
        field(1; "FA No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Job Component Header"."FA No." WHERE(Period = FIELD(Period),
                                                                   "Maintenance Type" = FIELD("Maintenance Type"));
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }
        field(3; "Component Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",FA,Item;
        }
        field(4; Component; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Component Type" = CONST(FA)) "Fixed Asset"
            ELSE
            IF ("Component Type" = CONST(Item)) Item;

            trigger OnValidate()
            begin
                IF "Component Type" = "Component Type"::FA THEN BEGIN
                    IF recFA.GET(Component) THEN
                        Description := recFA.Description;
                END ELSE
                    IF "Component Type" = "Component Type"::Item THEN BEGIN
                        IF recItem.GET(Component) THEN
                            Description := recItem.Description;
                    END
            end;
        }
        field(5; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Description; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Period; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Maintenance Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Maintenance Job,Miscellaneouse Job,Statutory Compliance Job,AMC Job,Break Down,calibration';
            OptionMembers = "Maintenance Job","Miscellaneouse Job","Statutory Compliance Job","AMC Job","Break Down",calibration;
        }
        field(9; Select; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "FA No.", "Line No.", Period, "Maintenance Type", "Component Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Component Type" = "Component Type"::" " THEN
            ERROR('Please update Component Type');
    end;

    var
        recFA: Record 5600;
        recItem: Record 27;
}

