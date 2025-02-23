<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="frontend/assets/css/reset.css">
    <link rel="stylesheet" href="frontend/assets/css/main.css">
    <title>Document</title>
</head>
<body>
    <h1>Site en cour de construction</h1>
    <?php
try {
    $host = "localhost"; // Ou l'adresse du serveur PostgreSQL
    $port = "5432"; // Port par défaut de PostgreSQL
    $dbname = "test"; // Nom de ta base de données
    $user = "postgres"; // Ton utilisateur PostgreSQL
    $password = "Roubys@85"; // Ton mot de passe PostgreSQL

    // Connexion avec PDO
    $pdo = new PDO("pgsql:host=$host;port=$port;dbname=$dbname", $user, $password);

    // Activer le mode exception pour les erreurs
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    echo "Connexion réussie !";

} catch (PDOException $e) {
    echo "Erreur de connexion : " . $e->getMessage();
}
?>




</body>
</html>