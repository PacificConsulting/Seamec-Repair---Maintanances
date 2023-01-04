table 50021 "Maintenance Line"
{

    fields
    {
        field(1; "Document No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Maintenance Header"."No.";
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Component Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,FA,Item,G/L Account,Resource';
            OptionMembers = " ",FA,Item,"G/L Account",Resource;

            trigger OnValidate()
            begin
                IF MaintenanceHeader.GET("Document No.") THEN
                    MaintenanceHeader.TESTFIELD(Status, MaintenanceHeader.Status::"Under Maintenance");
            end;
        }
        field(4; "Consumable Component"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Component Type" = CONST(FA)) "Fixed Asset"
            ELSE
            IF ("Component Type" = CONST(Item)) Item WHERE("Item Category Code" = FILTER('CN' | 'PM'))
            ELSE
            IF ("Component Type" = CONST("G/L Account")) "G/L Account" WHERE("Direct Posting" = CONST(true),
                                                                                             "Account Type" = CONST(Posting),
                                                                                             Blocked = CONST(false),
                                                                                             "Repair & Maintenance" = CONST(true))
            ELSE
            IF ("Component Type" = CONST(Resource)) Resource WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin
                IF MaintenanceHeader.GET("Document No.") THEN
                    MaintenanceHeader.TESTFIELD(MaintenanceHeader.Status, MaintenanceHeader.Status::"Under Maintenance");
                "Location Code" := MaintenanceHeader."Location Code";
                VALIDATE("Location Code");

                IF "Component Type" = "Component Type"::Item THEN BEGIN
                    IF Item.GET("Consumable Component") THEN
                        Description := Item.Description;
                END;
                IF "Component Type" = "Component Type"::"G/L Account" THEN BEGIN
                    IF GLAccount.GET("Consumable Component") THEN
                        Description := GLAccount.Name;
                END;
                IF "Component Type" = "Component Type"::FA THEN BEGIN
                    IF FixedAsset.GET("Consumable Component") THEN
                        Description := FixedAsset.Description;
                END;
                IF "Component Type" = "Component Type"::Resource THEN
                    IF Resource.GET("Consumable Component") THEN
                        Description := Resource.Name;
                "Unit Cost" := Resource."Direct Unit Cost";
            end;
        }
        field(5; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF MaintenanceHeader.GET("Document No.") THEN
                    MaintenanceHeader.TESTFIELD(Status, MaintenanceHeader.Status::"Under Maintenance");

                "Total Line Amount" := "Unit Cost" * Quantity;
            end;
        }
        field(6; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;

            trigger OnValidate()
            begin
                IF MaintenanceHeader.GET("Document No.") THEN
                    MaintenanceHeader.TESTFIELD(MaintenanceHeader.Status, MaintenanceHeader.Status::"Under Maintenance");
            end;
        }
        field(7; "Bin Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"));

            trigger OnValidate()
            begin
                IF MaintenanceHeader.GET("Document No.") THEN
                    MaintenanceHeader.TESTFIELD(Status, MaintenanceHeader.Status::"Under Maintenance");
                CLEAR(vBinQty);
                WarehouseEntry.RESET;
                WarehouseEntry.SETRANGE("Item No.", "Consumable Component");
                WarehouseEntry.SETRANGE("Location Code", "Location Code");
                WarehouseEntry.SETRANGE("Bin Code", "Bin Code");
                IF WarehouseEntry.FINDFIRST THEN
                    REPEAT
                        vBinQty += WarehouseEntry.Quantity;
                    UNTIL WarehouseEntry.NEXT = 0;
                "Inventory  Qty" := vBinQty;
            end;
        }
        field(8; "Inventory  Qty"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Consumable Component"),
                                                                  "Location Code" = FIELD("Location Code")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                IF MaintenanceHeader.GET("Document No.") THEN
                    MaintenanceHeader.TESTFIELD(Status, MaintenanceHeader.Status::"Under Maintenance");
            end;
        }
        field(9; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Description; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Quantity Utilized"; Decimal)
        {
            CalcFormula = - Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Consumable Component"),
                                                                   "Job Card Ref." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(12; "Req no."; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Req Line no."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Total Line Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                MaintenanceHeader.RESET;
                MaintenanceHeader.SETRANGE("No.", "Document No.");
                IF NOT MaintenanceHeader.FINDFIRST THEN BEGIN
                    IF (MaintenanceHeader."Resource Provider" = MaintenanceHeader."Resource Provider"::External) OR
                      (MaintenanceHeader."Resource Provider" = MaintenanceHeader."Resource Provider"::"Internal & External") THEN
                        ERROR('Vendor can be added if Resource Provider is mentioned as External or Internal & External');
                END;
                IF "Vendor No." <> '' THEN
                    Vendor.GET("Vendor No.");
                "Vendor Name" := Vendor.Name;
            end;
        }
        field(17; "Vendor Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Work Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Charge Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        WarehouseEntry: Record 7312;
        vBinQty: Decimal;
        ReserveItemJnlLine: Codeunit 99000835;
        MaintenanceHeader: Record 50016;
        MaintenanceHeader1: record 50016;
        Item: Record 27;
        GLAccount: Record 15;
        FixedAsset: Record 5600;
        Resource: Record 156;
        Vendor: Record 23;

    //[Scope('Internal')]
    procedure OpenItemTrackingLines(IsReclass: Boolean)
    begin
        ReserveItemJnlLine.CallItemTrackingML(Rec, IsReclass);
    end;
}

