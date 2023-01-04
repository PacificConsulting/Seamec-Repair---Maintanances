page 50033 "Repair & Maint. Consumables"
{
    AutoSplitKey = true;
    Caption = 'Repair & Maint. Consumables';
    PageType = ListPart;
    SourceTable = 50021;
    SourceTableView = WHERE("Component Type" = FILTER(Item | ' '));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Component Type"; rec."Component Type")
                {
                }
                field("Consumable Component"; rec."Consumable Component")
                {
                }
                field(Remarks; rec.Remarks)
                {
                }
                field(Description; rec.Description)
                {
                }
                field(Quantity; rec.Quantity)
                {
                }
                field("Location Code"; rec."Location Code")
                {
                }
                field("Bin Code"; rec."Bin Code")
                {
                }
                field("Inventory  Qty"; rec."Inventory  Qty")
                {
                }
                field("Quantity Utilized"; rec."Quantity Utilized")
                {
                }
                field("Req no."; rec."Req no.")
                {
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
        MaintenanceHeader: Record 50016;
        vEdit: Boolean;
}

