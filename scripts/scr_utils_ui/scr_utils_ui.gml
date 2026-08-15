function getEntityTypeColor(_type)
{
    if (variable_struct_exists(global.entity_type_colors, _type))
    {
        return global.entity_type_colors[$ _type];
    }

    return {
        selector: c_white,
        text: c_white
    };
}