page 50084 "Preventive Maintenance Master"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 50035;
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; rec.Type)
                {
                }
                field("Master Code"; rec."Master Code")
                {

                    trigger OnValidate()
                    begin
                        IF (rec.Type = rec.Type::Asset) OR (rec.Type = rec.Type::Component) OR (rec.Type = rec.Type::"Sub-Component 1")
                          OR (rec.Type = rec.Type::"Sub-Component 2") THEN
                            rec.TESTFIELD("Fixed Asset No.");
                        IF (rec.Type = rec.Type::"Sub-Component 1") OR (rec.Type = rec.Type::"Sub-Component 2") THEN
                            rec.TESTFIELD(Component);
                        IF rec.Type = rec.Type::"Sub-Component 2" THEN
                            rec.TESTFIELD("Sub-Component 1");
                    end;
                }
                field(Description; rec.Description)
                {
                }
                field("Fixed Asset No."; rec."Fixed Asset No.")
                {
                }
                field("Fixed Asset Description"; rec."Fixed Asset Description")
                {
                }
                field(Component; rec.Component)
                {

                    trigger OnValidate()
                    begin
                        PreventiveMaintenanceMaster.GET(rec.Component);
                        rec."Component Description" := PreventiveMaintenanceMaster.Description;
                    end;
                }
                field("Component Description"; rec."Component Description")
                {
                }
                field("Sub-Component 1"; rec."Sub-Component 1")
                {
                }
                field("Sub-Component 1 Description"; rec."Sub-Component 1 Description")
                {
                }
                field("Date & Time"; rec."Date & Time")
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        PreventiveMaintenanceMaster: Record 50035;
}

