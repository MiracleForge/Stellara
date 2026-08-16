function getFactionTransponderColor(_faction)
{
    if (_faction >= 0 && _faction < array_length(global.faction_data))
    {
        var _data = global.faction_data[_faction];

        if (variable_struct_exists(_data, "transponder"))
        {
            return _data.transponder;
        }
    }

    return {
        color: c_white,
        text: c_white
    };
}