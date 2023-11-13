-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 13 nov. 2023 à 18:25
-- Version du serveur : 10.4.22-MariaDB
-- Version de PHP : 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `moneyvalue`
--
CREATE DATABASE IF NOT EXISTS `moneyvalue` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `moneyvalue`;

-- --------------------------------------------------------

--
-- Structure de la table `currency`
--

DROP TABLE IF EXISTS `currency`;
CREATE TABLE `currency` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `symbol` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `flag` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `currency`
--

INSERT INTO `currency` (`id`, `code`, `full_name`, `symbol`, `flag`, `created_at`, `updated_at`) VALUES
(1, 'USD', 'United States Dollars', '$', 'none', '2023-11-11 12:04:01', '2023-11-13 15:59:39'),
(2, 'EUR', 'Euros', '€', 'none', '2023-11-11 12:04:01', '2023-11-13 15:56:05'),
(3, 'CAD', 'Canadian Dollar', 'CA$', 'none', '2023-11-13 06:39:45', '2023-11-13 06:39:45'),
(4, 'VES', 'Venezuelian Bolivare', 'Bs', 'none', '2023-11-13 06:49:13', '2023-11-13 06:49:13'),
(5, 'MXN', 'Mexican Peso', 'Mex$', 'none', '2023-11-13 07:19:15', '2023-11-13 07:19:15'),
(6, 'CHF', 'Swiss Franc', 'CHF', 'none', '2023-11-13 07:24:23', '2023-11-13 07:24:23'),
(7, 'ITL', 'Italian Lira', 'Lit', 'none', '2023-11-13 07:32:11', '2023-11-13 08:48:35'),
(11, 'TRY', 'Türk lirası', 'TL', 'none', '2023-11-13 09:01:36', '2023-11-13 09:01:36');

-- --------------------------------------------------------

--
-- Structure de la table `currency_pairs`
--

DROP TABLE IF EXISTS `currency_pairs`;
CREATE TABLE `currency_pairs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `source_currency_id` bigint(20) UNSIGNED NOT NULL,
  `target_currency_id` bigint(20) UNSIGNED NOT NULL,
  `rate` double NOT NULL,
  `hits` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `currency_pairs`
--

INSERT INTO `currency_pairs` (`id`, `source_currency_id`, `target_currency_id`, `rate`, `hits`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 1.1225, 0, '2023-11-11 12:04:04', '2023-11-13 13:21:10'),
(2, 2, 1, 0.8929, 0, '2023-11-13 12:07:12', '2023-11-13 12:07:12');

-- --------------------------------------------------------

--
-- Structure de la table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2014_10_12_200000_add_two_factor_columns_to_users_table', 2),
(12, '2023_11_11_080624_create_currency_table', 3),
(13, '2023_11_11_080852_create_currency_pairs_table', 3);

-- --------------------------------------------------------

--
-- Structure de la table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'your-token-name', '72d5754149cade3708be63de85c3ae98182009468079fba3c8b1680c1ee4c651', '[\"*\"]', NULL, NULL, '2023-11-12 21:25:19', '2023-11-12 21:25:19'),
(2, 'App\\Models\\User', 1, 'your-token-name', 'e31141768d94795338735997e3dfdd5daddc7443298f5aae2e51a2b17e476bf2', '[\"*\"]', NULL, NULL, '2023-11-12 21:28:54', '2023-11-12 21:28:54'),
(3, 'App\\Models\\User', 1, 'your-token-name', '79ec7dea4e850215106307b693c59279bdf5822f7665ccc1f257f3d30d4be194', '[\"*\"]', NULL, NULL, '2023-11-12 21:49:35', '2023-11-12 21:49:35'),
(4, 'App\\Models\\User', 1, 'your-token-name', 'a83924cf2a45fd4e6afb49aebf6932c224afaac917fe4b9a6ecf5ab49037553f', '[\"*\"]', NULL, NULL, '2023-11-12 21:56:43', '2023-11-12 21:56:43'),
(5, 'App\\Models\\User', 1, 'your-token-name', '60558860e037e751d90c3c5579d6d5b5e99b3efb991d49059f994f08c2c9d5e5', '[\"*\"]', NULL, NULL, '2023-11-12 21:56:56', '2023-11-12 21:56:56'),
(6, 'App\\Models\\User', 1, 'your-token-name', '5c2d4ae43243d38dca75dbd0cee049b070478db63747d792363483fd41440551', '[\"*\"]', NULL, NULL, '2023-11-12 21:57:49', '2023-11-12 21:57:49'),
(7, 'App\\Models\\User', 1, 'your-token-name', '82c01d5d31ddff9f749dbe89b04dd34b303c8ba33d3460a05ca40a105f3f735f', '[\"*\"]', NULL, NULL, '2023-11-12 21:59:51', '2023-11-12 21:59:51'),
(8, 'App\\Models\\User', 1, 'your-token-name', '16a5a2a1c937d6a45dd86472f33db161c8827431f30d4b1aa79db5379deacbad', '[\"*\"]', NULL, NULL, '2023-11-12 22:00:12', '2023-11-12 22:00:12'),
(9, 'App\\Models\\User', 1, 'your-token-name', 'c20a88f79a63cda2165a90aa4e3c424a5360c78bb3875e0f1e2f4bccfceef788', '[\"*\"]', NULL, NULL, '2023-11-12 22:25:48', '2023-11-12 22:25:48'),
(10, 'App\\Models\\User', 1, 'your-token-name', '320533e88c9997eac1e1fb6e0ffad5106075bd1f1990c5631186295c61c7675f', '[\"*\"]', NULL, NULL, '2023-11-12 23:11:27', '2023-11-12 23:11:27'),
(11, 'App\\Models\\User', 1, 'your-token-name', 'b9946bbaaf3d5d83f4151b51b8f69ea41ab601f1c57d911d3cb2a49b9f0e36ef', '[\"*\"]', NULL, NULL, '2023-11-12 23:29:24', '2023-11-12 23:29:24'),
(12, 'App\\Models\\User', 1, 'your-token-name', '6e8d7b0ad3c4b0ddef3352d783228886b90349b4ffce51cfc1f4c71712ff6d7e', '[\"*\"]', NULL, NULL, '2023-11-12 23:32:07', '2023-11-12 23:32:07'),
(13, 'App\\Models\\User', 1, 'your-token-name', '0e4b6d7c2409b1ac794163b3288d35e00e63294031bd43aed01ad12f21a359d2', '[\"*\"]', NULL, NULL, '2023-11-12 23:34:48', '2023-11-12 23:34:48'),
(14, 'App\\Models\\User', 1, 'your-token-name', 'cbc23cb6680acf47565bb3a267d5198af4b166c0f7ffb9f03ff467a935bb7a1b', '[\"*\"]', NULL, NULL, '2023-11-13 00:22:27', '2023-11-13 00:22:27'),
(15, 'App\\Models\\User', 1, 'your-token-name', '82bc63808bf9714f741ae39341744c6c2830dcafc0c8d7db7e45f725e40d6e48', '[\"*\"]', NULL, NULL, '2023-11-13 00:24:47', '2023-11-13 00:24:47'),
(16, 'App\\Models\\User', 1, 'your-token-name', '9e1de19e60e653f90671e91b2b77b04a6b43f36b96e64e54694ad8880fb6a706', '[\"*\"]', NULL, NULL, '2023-11-13 00:28:35', '2023-11-13 00:28:35'),
(17, 'App\\Models\\User', 1, 'your-token-name', 'f7276daa80dac3258d9bad3deec61276a3148e40e3d5959396bb6e6188f54d82', '[\"*\"]', NULL, NULL, '2023-11-13 00:35:41', '2023-11-13 00:35:41'),
(18, 'App\\Models\\User', 1, 'your-token-name', 'eb0b582d5b377bd6b49ee1accb34270ad5c5a9f46b3a5f91f33a0b91a5705afa', '[\"*\"]', NULL, NULL, '2023-11-13 00:43:41', '2023-11-13 00:43:41'),
(19, 'App\\Models\\User', 1, 'your-token-name', '3bd1625f6592fafea405ce0a368eb0236e93b5eb996be2a1849550939ff7c320', '[\"*\"]', NULL, NULL, '2023-11-13 01:00:04', '2023-11-13 01:00:04'),
(20, 'App\\Models\\User', 1, 'your-token-name', '8715927b0e8396cc5a0b5f97ce8b298fc969977b319a6e45c2ad1a651cd24b6a', '[\"*\"]', NULL, NULL, '2023-11-13 01:05:59', '2023-11-13 01:05:59'),
(21, 'App\\Models\\User', 1, 'your-token-name', '4de84cbbdd8088b7100ba3a10d14796cfb0905022c0ef7a9bf0966b707c2153c', '[\"*\"]', NULL, NULL, '2023-11-13 01:28:12', '2023-11-13 01:28:12'),
(22, 'App\\Models\\User', 1, 'your-token-name', '6976d07e521444d8265f2fb64bb755bcd1b7ee10e42ca1eac003080e53725fb5', '[\"*\"]', NULL, NULL, '2023-11-13 02:15:16', '2023-11-13 02:15:16'),
(23, 'App\\Models\\User', 1, 'your-token-name', 'b0f6f294cfaa317fe98ee78ab47c02275795218fc017fcc8b4cad716d75d8090', '[\"*\"]', NULL, NULL, '2023-11-13 03:24:10', '2023-11-13 03:24:10'),
(24, 'App\\Models\\User', 1, 'your-token-name', '60d5ce69e90afee577c8939e4b2fb92dd2fd8ea41353f205405ad5c59703a5e3', '[\"*\"]', NULL, NULL, '2023-11-13 03:47:11', '2023-11-13 03:47:11'),
(25, 'App\\Models\\User', 1, 'your-token-name', 'd21e8dd509c10c74bd7844f74f83b23fe3750b8dba08ee3fbee81977b3f46e3c', '[\"*\"]', NULL, NULL, '2023-11-13 06:37:56', '2023-11-13 06:37:56'),
(26, 'App\\Models\\User', 1, 'your-token-name', '3fd1864fa451dad81ccf6e4598085b99525d26f99c22f75a15f6fafd9ecdacd9', '[\"*\"]', NULL, NULL, '2023-11-13 08:55:52', '2023-11-13 08:55:52'),
(27, 'App\\Models\\User', 1, 'your-token-name', 'a135fe3fb336e94aadf82a85220e27ffdd05f86114560605c7cb99a90a702499', '[\"*\"]', NULL, NULL, '2023-11-13 08:57:29', '2023-11-13 08:57:29'),
(28, 'App\\Models\\User', 1, 'your-token-name', '2d721c7b14655c659ebcd8335f1d0613eb81ed5a400480a1aa827d2884af3eef', '[\"*\"]', NULL, NULL, '2023-11-13 11:45:14', '2023-11-13 11:45:14'),
(29, 'App\\Models\\User', 1, 'your-token-name', '3dc1612e7e817c06d2d36275009622e5f592fc43387e3937de80f7867eede5a5', '[\"*\"]', NULL, NULL, '2023-11-13 15:03:03', '2023-11-13 15:03:03');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'jcrangon', 'jc.rangon@gmail.com', NULL, '$2y$12$OH2rwkM72nqVc64r4Ru6reG1NfCiB.yydWNnttDJRZQIzNcJr436a', NULL, NULL, NULL, NULL, '2023-11-12 17:36:17', '2023-11-12 17:36:17');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `currency`
--
ALTER TABLE `currency`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `currency_pairs`
--
ALTER TABLE `currency_pairs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `currency_pairs_source_currency_id_foreign` (`source_currency_id`),
  ADD KEY `currency_pairs_target_currency_id_foreign` (`target_currency_id`);

--
-- Index pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Index pour la table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Index pour la table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `currency`
--
ALTER TABLE `currency`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `currency_pairs`
--
ALTER TABLE `currency_pairs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `currency_pairs`
--
ALTER TABLE `currency_pairs`
  ADD CONSTRAINT `currency_pairs_source_currency_id_foreign` FOREIGN KEY (`source_currency_id`) REFERENCES `currency` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `currency_pairs_target_currency_id_foreign` FOREIGN KEY (`target_currency_id`) REFERENCES `currency` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
