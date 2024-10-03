import 'package:fitwiz/data/models/user_short.dart';
import 'package:fitwiz/features/event/data/models/event_team.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EventTeam', () {
    test('should return valid model if valid json', () {
      final json = {
        'id': 1,
        'event_id': 1,
        'team_code': '0A0A',
        'name': 'Team 1',
        'leader': {
          'id': 1,
          'name': 'John Doe',
        },
        'members': [
          {
            'id': 2,
            'name': 'Jane Doe',
          },
        ],
      };

      final model = EventTeam.fromJson(json);

      expect(
        model,
        const EventTeam(
          id: 1,
          eventId: 1,
          teamCode: '0A0A',
          name: 'Team 1',
          leader: UserShort(id: 1, name: 'John Doe'),
          members: [UserShort(id: 2, name: 'Jane Doe')],
        ),
      );
    });

    test('should return valid json if valid model', () {
      const model = EventTeam(
        id: 1,
        eventId: 1,
        teamCode: '0A0A',
        name: 'Team 1',
        leader: UserShort(id: 1, name: 'John Doe'),
        members: [UserShort(id: 2, name: 'Jane Doe')],
      );

      final json = model.toJson();

      expect(
        json,
        {
          'id': 1,
          'event_id': 1,
          'team_code': '0A0A',
          'name': 'Team 1',
          'leader': {
            'id': 1,
            'name': 'John Doe',
          },
          'members': [
            {
              'id': 2,
              'name': 'Jane Doe',
            },
          ],
        },
      );
    });
  });
}
