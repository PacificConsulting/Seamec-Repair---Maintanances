page 50074 "Repair & Maint. Consumables"
{
    AutoSplitKey = true;
    Caption = 'Repair & Maint. Consumables';
    PageType = ListPart;
    SourceTable = 50033;
    SourceTableView = WHERE("Component Type" = FILTER(Item | ' '));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Component Type"; rec."Component Type")
                {
                    ApplicationArea = all;
                }
                field("Consumable Component"; rec."Consumable Component")
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
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Bin Code"; rec."Bin Code")
                {
                    ApplicationArea = all;
                }
                field("Inventory  Qty"; rec."Inventory  Qty")
                {
                    ApplicationArea = all;
                }
                field("Quantity Utilized"; rec."Quantity Utilized")
                {
                    ApplicationArea = all;
                }
                field("Req no."; rec."Req no.")
                {
                    ApplicationArea = all;
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
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        rec.OpenItemTrackingLines(FALSE);


                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        /*
        vEdit:=TRUE;
        IF MaintenanceHeader.GET("Document No.") THEN
          IF MaintenanceHeader."Maintenance Type"=MaintenanceHeader."Maintenance Type"::"Miscellaneouse Job" THEN
            vEdit:=FALSE;
        */

    end;

    var
        MaintenanceHeader: Record 50032;
        vEdit: Boolean;
}

