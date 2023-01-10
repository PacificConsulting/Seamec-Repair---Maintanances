page 50076 "Maintenance Work Order"
{
    AutoSplitKey = true;
    Caption = 'Maintenance Work Order';
    PageType = ListPart;
    SourceTable = 50033;
    SourceTableView = WHERE("Component Type" = FILTER("G/L Account"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; rec."Component Type")
                {
                    ApplicationArea = all;
                }
                field("G/L Account No."; rec."Consumable Component")
                {
                    ApplicationArea = all;
                }
                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Charge Description"; rec."Charge Description")
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Unit Cost"; rec."Unit Cost")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Vendor No."; rec."Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor Name"; rec."Vendor Name")
                {
                    ApplicationArea = all;
                }
                field("Work Order No."; rec."Work Order No.")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                }
                action(ItemTrackingLines)
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';
                    Visible = false;

                    trigger OnAction()
                    begin
                        rec.OpenItemTrackingLines(FALSE);

                    end;
                }
                action("Create Work Order")
                {
                    Caption = 'Create Work Order';
                    Image = CreateDocument;
                    //Promoted = true;
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        rec.TESTFIELD("Vendor No.");
                        rec.TESTFIELD("Work Order No.", '');
                        rec.TESTFIELD("Location Code"); //PCPL0017
                        MaintenanceLine.RESET;
                        MaintenanceLine.SETRANGE(MaintenanceLine."Document No.", rec."Document No.");
                        MaintenanceLine.SETRANGE(MaintenanceLine."Component Type", MaintenanceLine."Component Type"::"G/L Account");
                        MaintenanceLine.SETRANGE(MaintenanceLine."Line No.", rec."Line No.");
                        IF NOT MaintenanceLine.FINDFIRST THEN
                            ERROR('GL lines are not available in this Job Card')
                        ELSE BEGIN
                            MaintenanceHeader.RESET;
                            MaintenanceHeader.SETRANGE(MaintenanceHeader."No.", rec."Document No.");
                            IF MaintenanceHeader.FINDFIRST THEN //
                                PurchaseHeader.INIT;
                            PurchSetup.GET;
                            //PurchaseHeader."No.":=NoSeriesMgt.GetNextNo(PurchSetup."Order Nos.",TODAY,FALSE);
                            NoSeriesMgt.InitSeries(PurchSetup."Work Order No.", PurchSetup."Work Order No.", TODAY, PurchaseHeader."No.", PurchSetup."Work Order No.");
                            PurchaseHeader.VALIDATE(PurchaseHeader."Work Order", TRUE);
                            PurchaseHeader.VALIDATE(PurchaseHeader."Posting Date", TODAY);
                            PurchaseHeader.VALIDATE(PurchaseHeader."Document Type", PurchaseHeader."Document Type"::Order);
                            PurchaseHeader.VALIDATE(PurchaseHeader."Buy-from Vendor No.", MaintenanceLine."Vendor No.");
                            PurchaseHeader.VALIDATE(PurchaseHeader."Location Code", MaintenanceLine."Location Code");
                            PurchaseHeader.INSERT;
                            PurchaseHeader.VALIDATE(PurchaseHeader."Shortcut Dimension 1 Code", MaintenanceHeader."Shortcut Dimension 1 Code");
                            PurchaseHeader.VALIDATE(PurchaseHeader."Shortcut Dimension 2 Code", MaintenanceHeader."Shortcut Dimension 2 Code");
                            PurchaseHeader.MODIFY;

                            CLEAR(vLine);
                            MaintenanceLine.RESET;
                            MaintenanceLine.SETRANGE(MaintenanceLine."Document No.", rec."Document No.");
                            MaintenanceLine.SETRANGE(MaintenanceLine."Component Type", MaintenanceLine."Component Type"::"G/L Account");
                            MaintenanceLine.SETRANGE(MaintenanceLine."Line No.", rec."Line No.");
                            IF MaintenanceLine.FINDFIRST THEN
                                REPEAT
                                    PurchaseLine.RESET;
                                    PurchaseLine.SETRANGE(PurchaseLine."Document Type", PurchaseHeader."Document Type");
                                    PurchaseLine.SETRANGE(PurchaseLine."Document No.", PurchaseHeader."No.");
                                    IF PurchaseLine.FINDLAST THEN
                                        vLine := PurchaseLine."Line No." + 10000
                                    ELSE
                                        vLine := 10000;
                                    PurchaseLine.INIT;
                                    PurchaseLine."Document No." := PurchaseHeader."No.";
                                    PurchaseLine.VALIDATE(PurchaseLine."Document Type", PurchaseHeader."Document Type");
                                    PurchaseLine."Line No." := vLine;
                                    PurchaseLine.VALIDATE(PurchaseLine.Type, PurchaseLine.Type::"G/L Account");
                                    PurchaseLine.VALIDATE(PurchaseLine."No.", MaintenanceLine."Consumable Component");
                                    PurchaseLine.VALIDATE(PurchaseLine.Quantity, MaintenanceLine.Quantity);
                                    PurchaseLine.VALIDATE(PurchaseLine."Direct Unit Cost", MaintenanceLine."Unit Cost");
                                    PurchaseLine.VALIDATE(PurchaseLine."Charge Description", MaintenanceLine."Charge Description");
                                    PurchaseLine.INSERT;
                                    vLine += 10000;

                                UNTIL MaintenanceLine.NEXT = 0;
                            rec."Work Order No." := PurchaseHeader."No.";
                        END;
                        MESSAGE('Work Order is Created');
                    end;
                }
            }
        }
    }

    var
        PurchaseHeader: Record 38;
        PurchSetup: Record 312;
        PurchaseLine: Record 39;
        NoSeriesMgt: Codeunit 396;
        vLine: Integer;
        MaintenanceHeader: Record 50032;
        MaintenanceLine: Record 50033;
}

