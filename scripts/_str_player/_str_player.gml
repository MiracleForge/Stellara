function Player(_pilote, _shipType, _ship_name, _faction)
constructor
{
    profile = {
        pilote: _pilote,
        faction: _faction,
    };

    ship = new PlayerShip(_shipType, _ship_name, _faction);
    
    getTransponder = function() {
        return {
            type: "player",
            faction: profile.faction,
            transponder: true,
    
            fields: [
                {
                    label: "Pilote",
                    value: profile.pilote
                }
            ],
    
            children: [
                ship.getInfo()
            ]
        };
    };
}