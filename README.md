# REQUIREMENTS

Build an address book with the PagerDuty's user API.

[x] List all the users
[ ] #show action for specific user.  Show `first_name`, `last_name`, and `contact_method`
[x] Testing
[ ] Pagination
[ ] Verbose option?
[ ] Search option

# USAGE

Use bundle to install dependencies

```
bundle install
```

Make sure your token is exported in your environment, or inline:

```
> PD_API_TOKEN=api_token ./bin/pd-start users
```

Review available commands through the help command:

```
> ./bin/pd-start help
Commands:
  pd-start help [COMMAND]  # Describe available commands or one specific command
  pd-start users           # List all users
```