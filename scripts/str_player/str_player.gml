function Player(_name, _shipType)
constructor
{
    profile = {
        name: _name
    };

    ship = new PlayerShip(_shipType);
}