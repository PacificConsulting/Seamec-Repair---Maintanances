table 50032 "Maintenance Header"
{
    Caption = 'Maintenance Header';

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "FA No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset"."No.";

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::"Under Maintenance");
                IF recFA.GET("FA No.") THEN
                    "FA Description" := recFA.Description;
                IF "FA No." = '' THEN
                    "FA Description" := '';
            end;
        }
        field(3; "FA Description"; Text[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::"Under Maintenance");
            end;
        }
        field(4; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::"Under Maintenance");
            end;
        }
        field(5; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::"Under Maintenance");
            end;
        }
        field(6; "End Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::"Under Maintenance");
            end;
        }
        field(7; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::"Under Maintenance");
            end;
        }
        field(8; "Created By"; Code[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::"Under Maintenance");
            end;
        }
        field(9; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Under Maintenance,Close';
            OptionMembers = "Under Maintenance",Close;
        }
        field(10; Remarks; Text[80])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::"Under Maintenance");
            end;
        }
        field(11; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                IF Vendor.GET("Vendor No.") THEN
                    "Vendor Name" := Vendor.Name;
            end;
        }
        field(12; "Vendor Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Maintenance Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Preventive Maintenance,Miscellaneouse,Modification & Process Optimization,PM-AMC,Break Down,PM-Calibration';
            OptionMembers = "Preventive Maintenance",Miscellaneouse,"Modification & Process Optimization","PM-AMC","Break Down","PM-Calibration";
        }
        field(14; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            DataClassification = ToBeClassified;
            TableRelation = "Incoming Document";

            trigger OnValidate()
            var
                IncomingDocument: Record 130;
            begin
                IF "Incoming Document Entry No." = xRec."Incoming Document Entry No." THEN
                    EXIT;
                IF "Incoming Document Entry No." = 0 THEN
                    IncomingDocument.RemoveReferenceToWorkingDocument(xRec."Incoming Document Entry No.")
                ELSE
                    ; //PCPL/NSW/030123
                      // IncomingDocument.SetMHDoc(Rec); //PCPL/NSW/030123
            end;
        }
        field(15; "Work Order No."; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
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
                                                                                 Component = FIELD(Component));

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
                                                                                 Component = FIELD(Component),
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
        field(22; "Description of the Problem"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Nature of Problem"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "What Was Done"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Est. Production Loss (MT)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Category Of Problem"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Electrical,Mechanical,Power Fluctuation';
            OptionMembers = " ",Electrical,Mechanical,"Power Fluctuation";
        }
        field(27; "Creation Date-Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Break-Down Since"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Maintenance Activity Start"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Maintenance Activity Finish"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Production Restart"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Root Cause"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Resource Provider"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Internal,External,Internal & External';
            OptionMembers = Internal,External,"Internal & External";
        }
        field(34; "Is it a Production Loss"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(35; "Fault Found or Not"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(36; "Consumable Stockout"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Hours Consumed In Stockout"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(1),
                                                          Blocked = CONST(false));
        }
        field(39; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(2),
                                                          Blocked = CONST(false));
        }
        field(40; "Total Man Hours Utilized"; Decimal)
        {
            CalcFormula = Sum("Maintenance Line".Quantity WHERE("Document No." = FIELD("No."),
                                                                 "Component Type" = FILTER(Resource)));
            FieldClass = FlowField;
        }
        field(41; "Final Comments"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "FA No.", "Start Date")
        {
        }
    }

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            FASetup.GET;
            FASetup.TESTFIELD(FASetup."Maintenance Nos.");
            "No." := NoSeriesMgt.GetNextNo(FASetup."Maintenance Nos.", WORKDATE, TRUE);
        END;
        "Created By" := USERID;
        "Creation Date" := TODAY;
        "Creation Date-Time" := CURRENTDATETIME;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FASetup: Record 5603;
        recFA: Record 5600;
        Vendor: Record 23;
        PreventiveMaintenanceMaster: Record 50035;
        DimMgt: Codeunit 408;
}

