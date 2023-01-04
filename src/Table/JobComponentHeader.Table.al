table 50036 "Job Component Header"
{
    Caption = 'Maintenance Header';

    fields
    {
        field(1; "FA No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset"."No.";

            trigger OnValidate()
            begin
                IF recFA.GET("FA No.") THEN
                    "FA Description" := recFA.Description;
            end;
        }
        field(2; "FA Description"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Created By"; Code[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Under Maintenance,Close';
            OptionMembers = "Under Maintenance",Close;
        }
        field(8; Remarks; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                IF Vendor.GET("Vendor No.") THEN
                    "Vendor Name" := Vendor.Name;
            end;
        }
        field(10; "Vendor Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Maintenance Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Preventive Maintenance,Miscellaneouse,Modification & Process Optimization,PM-AMC,Break Down,PM-Calibration';
            OptionMembers = "Preventive Maintenance",Miscellaneouse,"Modification & Process Optimization","PM-AMC","Break Down","PM-Calibration";
        }
        field(12; Period; DateFormula)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //IF "Daily Job" = TRUE THEN
                //  ERROR('Daily Job must be False for mentioning Period');
                TESTFIELD("Daily Job", FALSE);
            end;
        }
        field(13; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
        field(14; "Next Job Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Daily Job"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TESTFIELD(Period);
            end;
        }
        field(16; Component; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Preventive Maintenance Master"."Master Code" WHERE(Type = CONST(Component),
                                                                                 "Fixed Asset No." = FIELD("FA No."));

            trigger OnValidate()
            begin

                PreventiveMaintenanceMaster.GET(PreventiveMaintenanceMaster.Type::Component, Component);
                "Component Description" := PreventiveMaintenanceMaster.Description;
            end;
        }
        field(17; "Component Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Sub-Component 1"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Preventive Maintenance Master"."Master Code" WHERE(Type = CONST("Sub-Component 1"),
                                                                                 "Fixed Asset No." = FIELD("FA No."),
                                                                                 Component = FIELD("Component"));

            trigger OnValidate()
            begin
                PreventiveMaintenanceMaster.GET(PreventiveMaintenanceMaster.Type::"Sub-Component 1", "Sub-Component 1");
                "Sub-Component 1 Description" := PreventiveMaintenanceMaster.Description;
            end;
        }
        field(19; "Sub-Component 1 Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Sub-Component 2"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Preventive Maintenance Master"."Master Code" WHERE(Type = CONST("Sub-Component 2"),
                                                                                 "Fixed Asset No." = FIELD("FA No."),
                                                                                 Component = FIELD("Component"),
                                                                                 "Sub-Component 1" = FIELD("Sub-Component 1"));

            trigger OnValidate()
            begin
                PreventiveMaintenanceMaster.GET(PreventiveMaintenanceMaster.Type::"Sub-Component 2", "Sub-Component 2");
                "Sub-Component 2 Description" := PreventiveMaintenanceMaster.Description;
            end;
        }

        field(21; "Sub-Component 2 Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "FA No.", Period, "Maintenance Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "FA No.", "FA Description", "End Date")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created By" := USERID;
        "Creation Date" := TODAY;
    end;


    var
        NoSeriesMgt: Codeunit 396;
        FASetup: Record 5603;
        recFA: Record 5600;
        Vendor: Record 23;
        PreventiveMaintenanceMaster: Record 50053;



}

