page 50082 "Preventive Maintenance M List"
{
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
}

