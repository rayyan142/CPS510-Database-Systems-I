import java.sql.*;
import java.util.Scanner;

public class JdbcOracleConnectionTemplate {

    public static void main(String[] args) {
        // Database connection string for Oracle DB
        String dbURL1 = "jdbc:oracle:thin:r1faisal/10286760@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))";

        try (Connection conn1 = DriverManager.getConnection(dbURL1)) {
            // Display a message when the connection is successfully established
            System.out.println("Connected with connection #1");

            Scanner scanner = new Scanner(System.in);

            // Main menu loop
            while (true) {
                // Display menu options to the user
                System.out.println("\n-----------------------------------");
                System.out.println("|  Car Rental Database Interface  |");
                System.out.println("-----------------------------------");
                System.out.println("1. Drop Tables");
                System.out.println("2. Create Tables");
                System.out.println("3. Populate Tables");
                System.out.println("4. Query Tables");
                System.out.println("5. Delete Records");
                System.out.println("6. Add Records");
                System.out.println("0. Exit");
                System.out.print("Enter your choice: ");

                int choice = scanner.nextInt();

                // Call the appropriate method based on user choice
                switch (choice) {
                    case 1:
                        dropTables(conn1);
                        break;
                    case 2:
                        createTables(conn1);
                        break;
                    case 3:
                        populateTables(conn1);
                        break;
                    case 4:
                        queryTables(scanner, conn1);
                        break;
                    case 5:
                        deleteRecords(scanner, conn1);
                        break;
                    case 6:
                        addRecords(scanner, conn1);
                        break;
                    case 0:
                        System.out.println("Exiting the program.");
                        return;
                    default:
                        System.out.println("Invalid choice. Please try again.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void dropTables(Connection conn) {
        String[] dropQueries = {
            "DROP TABLE customer_rental CASCADE CONSTRAINTS",
            "DROP TABLE rental CASCADE CONSTRAINTS",
            "DROP TABLE rental_dates CASCADE CONSTRAINTS",
            "DROP TABLE financial CASCADE CONSTRAINTS",
            "DROP TABLE payment CASCADE CONSTRAINTS",
            "DROP TABLE vehicle CASCADE CONSTRAINTS",
            "DROP TABLE inventory CASCADE CONSTRAINTS",
            "DROP TABLE customer CASCADE CONSTRAINTS",
            "DROP TABLE admin CASCADE CONSTRAINTS"
        };

        try (Statement stmt = conn.createStatement()) {
            for (String query : dropQueries) {
                try {
                    stmt.execute(query);
                } catch (SQLException e) {
                    if (!e.getMessage().contains("ORA-00942")) {
                        throw e;
                    }
                }
            }
            System.out.println("Tables dropped successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void createTables(Connection conn) {
        String[] createQueries = {
            "CREATE TABLE customer (customer_id NUMBER PRIMARY KEY, user_name VARCHAR2(100) NOT NULL, driver_license_number VARCHAR2(50) NOT NULL UNIQUE, contact_info VARCHAR2(150), user_address VARCHAR2(255))",
            "CREATE TABLE admin (admin_id NUMBER PRIMARY KEY, admin_name VARCHAR2(100))",
            "CREATE TABLE inventory (inventory_id NUMBER PRIMARY KEY, category VARCHAR2(100), availability VARCHAR2(50))",
            "CREATE TABLE vehicle (vehicle_id NUMBER PRIMARY KEY, vehicle_make VARCHAR2(100), vehicle_model VARCHAR2(100), inventory_id NUMBER REFERENCES inventory (inventory_id))",
            "CREATE TABLE payment (payment_id NUMBER PRIMARY KEY, customer_id NUMBER REFERENCES customer (customer_id), payment_type VARCHAR2(50), payment_info VARCHAR2(100), payment_amount NUMBER, payment_date DATE)",
            "CREATE TABLE financial (financial_id NUMBER PRIMARY KEY, earnings NUMBER, insurance_cost NUMBER, maintenance_cost NUMBER, payment_id NUMBER REFERENCES payment (payment_id))",
            "CREATE TABLE rental_dates (payment_id NUMBER PRIMARY KEY, date_of_rental DATE, FOREIGN KEY (payment_id) REFERENCES payment(payment_id))",
            "CREATE TABLE rental (rental_id NUMBER PRIMARY KEY, rental_duration NUMBER, rental_cost NUMBER, customer_id NUMBER REFERENCES customer (customer_id), vehicle_id NUMBER REFERENCES vehicle (vehicle_id), financial_id NUMBER REFERENCES financial (financial_id))",
            "CREATE TABLE customer_rental (customer_id NUMBER REFERENCES customer (customer_id), customer_name VARCHAR2(100), rental_id NUMBER REFERENCES rental (rental_id), PRIMARY KEY (customer_id, rental_id))"
        };

        try (Statement stmt = conn.createStatement()) {
            for (String query : createQueries) {
                stmt.execute(query);
            }
            System.out.println("Tables created successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void populateTables(Connection conn) {
        String[] insertQueries = {
            "INSERT INTO customer (customer_id, user_name, driver_license_number, contact_info, user_address) VALUES (1, 'Rayyan Faisal', 'DL123456', 'r1faisal@torontomu.ca', 'M5B 2K3')",
            "INSERT INTO customer (customer_id, user_name, driver_license_number, contact_info, user_address) VALUES (2, 'Aman Dhillon', 'DL223456', 'aman.dhillon@torontomu.ca', 'M5B 2K3')",
            "INSERT INTO inventory (inventory_id, category, availability) VALUES (1, 'SUV', 'available')",
            "INSERT INTO vehicle (vehicle_id, vehicle_make, vehicle_model, inventory_id) VALUES (1, 'Honda', 'Civic', 1)",
            "INSERT INTO payment (payment_id, customer_id, payment_type, payment_info, payment_amount, payment_date) VALUES (1, 1, 'Credit Card', 'Visa', 600, TO_DATE('2023-01-01', 'YYYY-MM-DD'))",
            "INSERT INTO financial (financial_id, earnings, insurance_cost, maintenance_cost, payment_id) VALUES (1, 500, 50, 20, 1)",
            "INSERT INTO rental (rental_id, rental_duration, rental_cost, customer_id, vehicle_id, financial_id) VALUES (1, 7, 300, 1, 1, 1)"
        };

        try (Statement stmt = conn.createStatement()) {
            for (String query : insertQueries) {
                stmt.execute(query);
            }
            System.out.println("Tables populated successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void deleteRecords(Scanner scanner, Connection conn) {
        System.out.println("\nSelect Table to Delete Records From:");
        System.out.println("1. Customer");
        System.out.println("2. Vehicle");
        System.out.println("3. Rental");
        System.out.println("4. Payment");
        System.out.print("Enter your choice: ");

        int choice = scanner.nextInt();
        String tableName = "";
        String condition = "";

        switch (choice) {
            case 1:
                tableName = "customer";
                System.out.print("Enter customer_id to delete: ");
                condition = "customer_id = " + scanner.nextInt();
                break;
            case 2:
                tableName = "vehicle";
                System.out.print("Enter vehicle_id to delete: ");
                condition = "vehicle_id = " + scanner.nextInt();
                break;
            case 3:
                tableName = "rental";
                System.out.print("Enter rental_id to delete: ");
                condition = "rental_id = " + scanner.nextInt();
                break;
            case 4:
                tableName = "payment";
                System.out.print("Enter payment_id to delete: ");
                condition = "payment_id = " + scanner.nextInt();
                break;
            default:
                System.out.println("Invalid choice. Returning to main menu.");
                return;
        }

        String deleteQuery = "DELETE FROM " + tableName + " WHERE " + condition;

        try (Statement stmt = conn.createStatement()) {
            int rowsAffected = stmt.executeUpdate(deleteQuery);
            if (rowsAffected > 0) {
                System.out.println("Record(s) deleted successfully.");
            } else {
                System.out.println("No records found matching the condition.");
            }
        } catch (SQLException e) {
            System.out.println("Error deleting record(s): " + e.getMessage());
        }
    }

    private static void addRecords(Scanner scanner, Connection conn) {
        System.out.println("\nSelect Table to Add Records To:");
        System.out.println("1. Customer");
        System.out.println("2. Vehicle");
        System.out.println("3. Rental");
        System.out.println("4. Payment");
        System.out.print("Enter your choice: ");

        int choice = scanner.nextInt();
        scanner.nextLine(); // Consume newline character
        String insertQuery = "";

        switch (choice) {
            case 1:
                System.out.print("Enter customer_id: ");
                int customerId = scanner.nextInt();
                scanner.nextLine();
                System.out.print("Enter user_name: ");
                String userName = scanner.nextLine();
                System.out.print("Enter driver_license_number: ");
                String license = scanner.nextLine();
                System.out.print("Enter contact_info: ");
                String contact = scanner.nextLine();
                System.out.print("Enter user_address: ");
                String address = scanner.nextLine();
                insertQuery = "INSERT INTO customer (customer_id, user_name, driver_license_number, contact_info, user_address) VALUES (" + customerId + ", '" + userName + "', '" + license + "', '" + contact + "', '" + address + "')";
                break;
            case 2:
                System.out.print("Enter vehicle_id: ");
                int vehicleId = scanner.nextInt();
                scanner.nextLine();
                System.out.print("Enter vehicle_make: ");
                String make = scanner.nextLine();
                System.out.print("Enter vehicle_model: ");
                String model = scanner.nextLine();
                System.out.print("Enter inventory_id: ");
                int inventoryId = scanner.nextInt();
                insertQuery = "INSERT INTO vehicle (vehicle_id, vehicle_make, vehicle_model, inventory_id) VALUES (" + vehicleId + ", '" + make + "', '" + model + "', " + inventoryId + ")";
                break;
            case 3:
                System.out.print("Enter rental_id: ");
                int rentalId = scanner.nextInt();
                System.out.print("Enter rental_duration: ");
                int duration = scanner.nextInt();
                System.out.print("Enter rental_cost: ");
                int cost = scanner.nextInt();
                System.out.print("Enter customer_id: ");
                int rentalCustomerId = scanner.nextInt();
                System.out.print("Enter vehicle_id: ");
                int rentalVehicleId = scanner.nextInt();
                System.out.print("Enter financial_id: ");
                int rentalFinancialId = scanner.nextInt();
                insertQuery = "INSERT INTO rental (rental_id, rental_duration, rental_cost, customer_id, vehicle_id, financial_id) VALUES (" + rentalId + ", " + duration + ", " + cost + ", " + rentalCustomerId + ", " + rentalVehicleId + ", " + rentalFinancialId + ")";
                break;
            case 4:
                System.out.print("Enter payment_id: ");
                int paymentId = scanner.nextInt();
                System.out.print("Enter customer_id: ");
                int paymentCustomerId = scanner.nextInt();
                scanner.nextLine();
                System.out.print("Enter payment_type: ");
                String paymentType = scanner.nextLine();
                System.out.print("Enter payment_info: ");
                String paymentInfo = scanner.nextLine();
                System.out.print("Enter payment_amount: ");
                int paymentAmount = scanner.nextInt();
                scanner.nextLine();
                System.out.print("Enter payment_date (YYYY-MM-DD): ");
                String paymentDate = scanner.nextLine();
                insertQuery = "INSERT INTO payment (payment_id, customer_id, payment_type, payment_info, payment_amount, payment_date) VALUES (" + paymentId + ", " + paymentCustomerId + ", '" + paymentType + "', '" + paymentInfo + "', " + paymentAmount + ", TO_DATE('" + paymentDate + "', 'YYYY-MM-DD'))";
                break;
            default:
                System.out.println("Invalid choice. Returning to main menu.");
                return;
        }

        try (Statement stmt = conn.createStatement()) {
            stmt.execute(insertQuery);
            System.out.println("Record added successfully.");
        } catch (SQLException e) {
            System.out.println("Error adding record: " + e.getMessage());
        }
    }

    private static void queryTables(Scanner scanner, Connection conn) {
        System.out.println("\nSelect Query:");
        System.out.println("1. Rentals > 5 Days");
        System.out.println("2. Rental Count per Customer");
        System.out.println("3. Earnings and Insurance Costs");
        System.out.println("4. Available Vehicles");
        System.out.println("5. Rental Cost Statistics");
        System.out.println("6. Customers with Payments > $500");
        System.out.print("Enter your query choice: ");

        int choice = scanner.nextInt();
        executeQuery(choice, conn);
    }

    private static void executeQuery(int choice, Connection conn) {
        String query = "";

        switch (choice) {
            case 1:
                query = "SELECT c.user_name, v.vehicle_make, v.vehicle_model, r.rental_duration FROM customer c JOIN rental r ON c.customer_id = r.customer_id JOIN vehicle v ON r.vehicle_id = v.vehicle_id WHERE r.rental_duration > 5";
                break;
            case 2:
                query = "SELECT c.user_name, COUNT(r.rental_id) AS rental_count FROM customer c JOIN rental r ON c.customer_id = r.customer_id GROUP BY c.user_name ORDER BY rental_count DESC";
                break;
            case 3:
                query = "SELECT v.vehicle_make, v.vehicle_model, SUM(f.earnings) AS vehicle_earnings, AVG(f.insurance_cost) AS average_insurance_cost FROM vehicle v JOIN rental r ON v.vehicle_id = r.vehicle_id JOIN financial f ON r.financial_id = f.financial_id GROUP BY v.vehicle_make, v.vehicle_model";
                break;
            case 4:
                query = "SELECT v.vehicle_make, v.vehicle_model FROM vehicle v JOIN inventory i ON v.inventory_id = i.inventory_id WHERE i.availability = 'available'";
                break;
            case 5:
                query = "SELECT MIN(r.rental_cost) AS lowest_rental_cost, MAX(r.rental_cost) AS highest_rental_cost, AVG(r.rental_cost) AS average_rental_cost FROM rental r";
                break;
            case 6:
                query = "SELECT c.user_name, SUM(p.payment_amount) AS total_payments FROM customer c JOIN payment p ON c.customer_id = p.customer_id GROUP BY c.user_name HAVING SUM(p.payment_amount) > 500";
                break;
            default:
                System.out.println("Invalid query choice. Try again.");
                return;
        }

        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();

            boolean hasResults = false;
            System.out.println("\nQuery Results:");
            while (rs.next()) {
                hasResults = true;
                for (int i = 1; i <= columnCount; i++) {
                    System.out.print(metaData.getColumnLabel(i) + ": " + rs.getString(i) + " ");
                }
                System.out.println();
            }

            if (!hasResults) {
                System.out.println("No results found for the query.");
            }
        } catch (SQLException e) {
            System.out.println("Error executing query: " + e.getMessage());
        }
    }
}
