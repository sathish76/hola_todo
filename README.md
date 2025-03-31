# hola_todo

The focus is on building a robust and user-friendly
solution with proper coding practices, modular
architecture, and adherence to design principles.
Candidates are encouraged to prioritize functionality,
code quality, and user experience while following the
given guidelines.

# User Stories - Tasks List
● As a user, I want tasks to be grouped by their due
date so that I can view them with the same deadline
together.
● As a user, I want each task to display its name, a
brief description (2 lines max), due date and tags.
● As a user, I want to mark tasks as complete from
the list so that I can efficiently manage my tasks.
● As a user, I want to sort my tasks by their due date
ascending or descending so that I can prioritize
them easily.
● As a user, I want to filter tasks based on tags and/or
due date range so that I can quickly find relevant
tasks.

# User Stories - Tasks CRUD
● As a user, I want to create a new task by
providing a name, description, due date, and
tags to organize my to-dos effectively.
● As a user, I should be able to view or update
the task details.
● As a user, I want to mark a task as completed.
Completed task should be deleted as well.
● As a user, I should be able to delete a task
from the task details or by swiping left from the
tasks list.
● As a user, I should be prompted before
applying destructive action like deleting a task.


# User Stories - Task Notifications
● As a user, I want to receive a notification when a
task is due, even if the app is in the background or
closed, so that I don’t miss deadlines.
● As a user, I want to mark a task as complete or
snooze it for 1 hour directly from the notification so
that I can take quick action without opening the
app.
● As a user, I want to tap on a notification to be taken
directly to the relevant task in the app so that I can
review or edit it.

# General Guidelines
● As a user, I want the app to work on both iOS and
Android so that I can use it regardless of my device.
● As a user, I want my tasks to be stored locally so
that they are available across the app sessions.
● [BONUS FEATURES] ○ As a user, I want smooth and engaging
animations so that the app feels modern
and polished.
○ As a user, I want the app’s interface to
adapt seamlessly across mobile and tablet
devices so that my experience feels
consistent.

# Developer Requirements
● As a developer, I want the code to follow SOLID
principles so that it is clean, maintainable, and
scalable.
● As a developer, I want UI components to be
modular so that they are reusable and easy to
maintain.
● As a developer, I will use design tokens for colors
and font styles so that the app adheres to a
consistent design system.
● As a developer, I will write unit tests for the logical
code at least.
● As a developer, I will design data models with
immutability in mind.
● As a developer, I will ensure resolving all the lint
issues before submitting the assignment.

# Restrictions
● State Management
    ○ Mandatory: MobX
    ○ Not Allowed: GetX
● Local Database
    ○ Recommended: Drift or better SQLite-based
    solution
    ○ Not Allowed: NoSQL-based databases
● Dependency Injection / Service Locator
    ○ Recommended: get_it and provider
● Immutable Models
    ○ Recommended: Freezed
● Notifications Management
    ○ Recommended: flutter_local_notifications
● Linter
    ○ Recommended: flutter_lints
