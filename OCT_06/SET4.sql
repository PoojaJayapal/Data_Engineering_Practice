CREATE TABLE vehicles (
    vehicle_id INT PRIMARY KEY,
    vehicle_name VARCHAR(100),
    vehicle_type VARCHAR(50),
    daily_rate DECIMAL(10,2),
    available_status VARCHAR(20)
);

INSERT INTO vehicles VALUES
(1, 'Honda City', 'Car', 2500, 'Available'),
(2, 'Toyota Innova', 'Car', 3500, 'Available'),
(3, 'Royal Enfield', 'Bike', 1200, 'Rented'),
(4, 'Activa', 'Scooter', 700, 'Available'),
(5, 'Mahindra Thar', 'SUV', 4500, 'Rented'),
(6, 'Hyundai Creta', 'SUV', 3200, 'Available'),
(7, 'KTM Duke', 'Bike', 1500, 'Available');

DELIMITER $$

-- 1. GetAllVehicles
DROP PROCEDURE IF EXISTS GetAllVehicles$$
CREATE PROCEDURE GetAllVehicles()
BEGIN
    SELECT * FROM vehicles;
END$$

-- 2. GetAvailableVehicles
DROP PROCEDURE IF EXISTS GetAvailableVehicles$$
CREATE PROCEDURE GetAvailableVehicles()
BEGIN
    SELECT * FROM vehicles
    WHERE available_status = 'Available';
END$$

-- 3. Vehicles of a given type
DROP PROCEDURE IF EXISTS GetVehiclesByType$$
CREATE PROCEDURE GetVehiclesByType(IN p_type VARCHAR(50))
BEGIN
    SELECT * FROM vehicles
    WHERE vehicle_type = p_type;
END$$

-- 4. Vehicles with daily rate up to a maximum
DROP PROCEDURE IF EXISTS GetVehiclesByMaxRate$$
CREATE PROCEDURE GetVehiclesByMaxRate(IN p_max_rate DECIMAL(10,2))
BEGIN
    SELECT * FROM vehicles
    WHERE daily_rate <= p_max_rate;
END$$

-- 5. Update the daily rate of a vehicle
DROP PROCEDURE IF EXISTS UpdateDailyRate$$
CREATE PROCEDURE UpdateDailyRate(IN p_vehicle_id INT, IN p_new_rate DECIMAL(10,2))
BEGIN
    UPDATE vehicles
    SET daily_rate = p_new_rate
    WHERE vehicle_id = p_vehicle_id;
END$$

-- 6. Change the status of a vehicle
DROP PROCEDURE IF EXISTS ChangeVehicleStatus$$
CREATE PROCEDURE ChangeVehicleStatus(IN p_vehicle_id INT, IN p_status VARCHAR(20))
BEGIN
    UPDATE vehicles
    SET available_status = p_status
    WHERE vehicle_id = p_vehicle_id;
END$$

-- 7. Increase the daily rate of all vehicles by a percentage
DROP PROCEDURE IF EXISTS IncreaseDailyRate$$
CREATE PROCEDURE IncreaseDailyRate(IN p_percent DECIMAL(5,2))
BEGIN
    UPDATE vehicles
    SET daily_rate = daily_rate + (daily_rate * p_percent / 100);
END$$

-- 8. Delete a vehicle by ID
DROP PROCEDURE IF EXISTS DeleteVehicle$$
CREATE PROCEDURE DeleteVehicle(IN p_vehicle_id INT)
BEGIN
    DELETE FROM vehicles
    WHERE vehicle_id = p_vehicle_id;
END$$

-- 9. Vehicles between two rental rates
DROP PROCEDURE IF EXISTS GetVehiclesBetweenRates$$
CREATE PROCEDURE GetVehiclesBetweenRates(IN p_min_rate DECIMAL(10,2), IN p_max_rate DECIMAL(10,2))
BEGIN
    SELECT * FROM vehicles
    WHERE daily_rate BETWEEN p_min_rate AND p_max_rate;
END$$

-- 10. Count vehicles of a given type
DROP PROCEDURE IF EXISTS CountVehiclesByType$$
CREATE PROCEDURE CountVehiclesByType(IN p_type VARCHAR(50))
BEGIN
    SELECT COUNT(*) AS total_vehicles
    FROM vehicles
    WHERE vehicle_type = p_type;
END$$

DELIMITER ;


--  CALLING THE PROCEDURES 

CALL GetAllVehicles();                      
CALL GetAvailableVehicles();                 
CALL GetVehiclesByType('SUV');               
CALL GetVehiclesByMaxRate(2500);             
CALL UpdateDailyRate(1, 2800);               
CALL ChangeVehicleStatus(3, 'Available');    
CALL IncreaseDailyRate(10);                  
CALL DeleteVehicle(7);                       
