# REQUIREMENTS

Build an address book with the PagerDuty's user API.

Hard requirements:
```
[x] List all the users
[x] Get action for specific user.  Show `first_name`, `last_name`, and `contact_methods`
[x] Testing
```

TODO and future considerations:
```
[ ] Pagination
[ ] Caching
[ ] POROs for all nested objects (contact methods, teams, etc)
[ ] Name Search
[ ] Namespacing based on entity (Users, Incidents, etc)
[ ] Verbose mode. Today's version would be verbose, but a slimmed down version could be scripted better
[ ] Handle non 200 HTTP codes from the server
```

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
  pd-start user            # Display data on a specific user
  pd-start users           # List all users
```

# PATTERNS

For working with the data given from the API, I took a very object oriented approach, which can be seen with the User PORO.  This pattern would be something I would use and test for nested objects.

When building CLIs I'm a big advocate for visual outputs, and thats why I chose to include color options and abstract out the print_to_user code.  This also allows for an easier refactor path to maybe include some dependency injection for other forms of output.  Something that may not be a puts statement

For now, as a v1, I just settled with red error text and a SystemExit when encountering an error.  However, in the future I would want a presenter for errors, and use namespaced errors to handle errors encountered with the API.

For testing, I love to have as 'prod-like' data as possible.  So when it came to working with code for the users endpoint, I wanted my test code to work with the real JSON that the server returns.  That is stored in the fixtures.  To reduce brittleness in the future (api payloads changing), a proper integration test would be helpful.  This would be more of a contract test to verify that what is given out today is still what my code is expecting.