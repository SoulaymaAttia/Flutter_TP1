import 'package:flutter/material.dart';

class ProfilePageM3 extends StatelessWidget {
  const ProfilePageM3({Key? key}) : super(key: key);

  Widget _buildStatChip(String value, String label, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Profil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Étape 1: Photo de profil avec badge
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 56,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Étape 2: Nom et titre
            Text(
              'Mohamed Tounsi',
              style: textTheme.headline5?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Développeur Flutter',
              style: textTheme.bodyText1?.copyWith(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 32),

            // Étape 3: Statistiques
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildStatChip('128', 'Abonnés', colorScheme),
                _buildStatChip('56', 'Projets', colorScheme),
                _buildStatChip('2 ans', 'Expérience', colorScheme),
              ],
            ),
            const SizedBox(height: 32),

            // Étape 4: Section "À propos"
            Card(
              elevation: 0,
              color: Colors.grey[100],
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'À propos',
                          style: textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Passionné par le développement mobile et les technologies innovantes. J\'aime créer des applications qui améliorent la vie des utilisateurs.',
                      style: textTheme.bodyText1?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.7),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Étape 5: Bouton flottant
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Action de modification
          debugPrint('Modification du profil');
        },
        icon: const Icon(Icons.edit),
        label: const Text('Modifier le profil'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}