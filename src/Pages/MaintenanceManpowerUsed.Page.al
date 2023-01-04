page 50219 "Maintenance Manpower Used"
{
    AutoSplitKey = true;
    Caption = 'Maintenance Manpower Used';
    PageType = ListPart;
    SourceTable = 50021;
    SourceTableView = WHERE("Component Type" = FILTER(Resource));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Component Type"; rec."Component Type")
                {
                }
                field("Resource Utilized"; rec."Consumable Component")
                {
                }
                field(Remarks; rec.Remarks)
                {
                }
                field(Description; rec.Description)
                {
                }
                field("Hours Utilized"; rec.Quantity)
                {
                }
                field("Unit Cost"; rec."Unit Cost")
                {
                    Visible = True;//Visibility;
                }
                field("Location Code"; rec."Location Code")
                {
                    Visible = false;
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

    trigger OnAfterGetRecord()
    begin

        UserSetup.GET(USERID);
        // IF UserSetup."Hide Resource Cost" THEN BEGIN
        //     Visibility := FALSE
        // END ELSE
        //     Visibility := TRUE;
    end;

    var
        UserSetup: Record 91;
        Visibility: Boolean;
}

