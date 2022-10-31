## Features

Grist API implementation for flutter

## Usage

### Create API Object

You can get docs_id and api_key settings

Server key is your URL, docs.getgrist.com if you're not using team.
And teamname.getgrist.com if you are in team.

```dart
final gristApi = GristAPI('docs_id' , 'api_key', server: 'https://docs.getgrist.com');
```

### Fetch data from table

Note: Name is one of the sample field that we are using.

```dart
final ret = await gristApi.fetchRecords('TableName', {});
for (var v in ret) {
  print(v['fields']['Name']);
}
```

### Add data

Return value will contains new id that created.

```dart
final ret = await gristApi.addRecords('TableName', [{"Name": "This is a new name"}]);
```

### Update data
Update records, be sure to include 'id' fields on the data that being updated.

```dart
final ret = await gristApi.updateRecords('TableName', [{"id": 19, "Name": "Update name to this"}]);
```

### Delete data
Delete data, parameter is just list of ids that wants to be deleted.

```dart
final ret = await gristApi.deleteRecords('TableName', [18]);
```

## Additional information

GRIST API : https://support.getgrist.com/rest-api/

