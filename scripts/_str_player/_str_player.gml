function Player(_name, _shipType)
constructor
{
    profile = {
        name: _name
    };

    ship = new PlayerShip(_shipType);
    
    getInfo = function() {
        return {
            type: "player",
    
            fields: [
                {
                    label: "Name",
                    value: profile.name
                }
            ],
    
            children: [
                ship.getInfo()
            ]
        };
    };
}