page 50077 "Maintenance FA SubPage"
{
    AutoSplitKey = true;
    Caption = 'Job task FA Line';
    PageType = ListPart;
    SourceTable = 50033;
    SourceTableView = WHERE("Component Type" = FILTER(FA));

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
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        rec.OpenItemTrackingLines(FALSE);

                    end;
                }
            }
        }
    }
}

