table 50053 "Preventive Maintenance Master"
{
    DrillDownPageID = 50208;
    LookupPageID = 50208;

    fields
    {
        field(1; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Asset,Component,Sub-Component 1,Sub-Component 2';
            OptionMembers = Asset,Component,"Sub-Component 1","Sub-Component 2";
        }
        field(2; "Master Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = FILTER(Asset)) "Fixed Asset" WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin
                IF Type = Type::Asset THEN
                    FixedAsset.GET("Master Code");
                Description := FixedAsset.Description;
                /*
                IF (Type = Type::Asset) OR  (Type = Type::Component) OR (Type = Type::"Sub-Component 1")
                  OR (Type = Type::"Sub-Component 2") THEN
                  TESTFIELD("Fixed Asset No.");
                IF (Type = Type::"Sub-Component 1") OR (Type = Type::"Sub-Component 2") THEN
                  TESTFIELD(Component);
                IF Type = Type::"Sub-Component 2" THEN
                  TESTFIELD("Sub-Component 1");
                */

            end;
        }
        field(3; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Fixed Asset No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset";

            trigger OnValidate()
            begin
                FixedAsset.GET("Fixed Asset No.");
                "Fixed Asset Description" := FixedAsset.Description;
            end;
        }
        field(6; "Fixed Asset Description"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; Component; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Preventive Maintenance Master"."Master Code" WHERE(Type = CONST(Component),
                                                                                 "Fixed Asset No." = FIELD("Fixed Asset No."));

            trigger OnValidate()
            begin
                IF (Type = Type::Component) OR (Type = Type::Asset) THEN
                    ERROR('Component entry is not allowed when type is selected as Component or Asset on the same line.');
                /*
                PreventiveMaintenanceMaster.GET(Component);
                "Component Description" := PreventiveMaintenanceMaster.Description;
                */

            end;
        }
        field(8; "Component Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Sub-Component 1"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Preventive Maintenance Master"."Master Code" WHERE(Type = CONST("Sub-Component 1"),
                                                                                 "Fixed Asset No." = FIELD("Fixed Asset No."),
                                                                                 Component = FIELD(Component));

            trigger OnValidate()
            begin
                IF (Type = Type::Asset) OR (Type = Type::Component) OR (Type = Type::"Sub-Component 1") THEN
                    ERROR('Sub-Component 1 entry is not allowed when type is selected as Asset or Component or Sub-Component 1 on the same line.');
            end;
        }
        field(10; "Sub-Component 1 Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Date & Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; Type, "Master Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Master Code", Description, "Fixed Asset No.", "Fixed Asset Description", Component, "Component Description", "Sub-Component 1", "Sub-Component 1 Description", "Date & Time")
        {
        }
    }

    trigger OnInsert()
    begin
        "Date & Time" := CURRENTDATETIME;
    end;

    var
        FixedAsset: Record 5600;
        PreventiveMaintenanceMaster: Record 50053;
}

