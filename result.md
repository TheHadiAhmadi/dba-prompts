## ApiTokens
Stores API tokens used for authentication and authorization purposes
### Fields
* **Id** (CHAR(36) - PRIMARY KEY):Unique identifier for the API token
* **Name** (VARCHAR(255) - NOT NULL):Name of the API token
* **Description** (TEXT - ):Description of the API token
* **Key** (VARCHAR(255) - NOT NULL):API key value
* **Secret** (VARCHAR(255) - NOT NULL):API secret value
* **ExpireAt** (DATETIME - ):Expiration date and time of the API token
* **Enabled** (TINYINT(1) - NOT NULL, DEFAULT 1):Indicates if the API token is enabled
* **CreatedBy** (VARCHAR(255) - NOT NULL):User who created the API token
* **CreatedAt** (DATETIME - NOT NULL):Date and time when the API token was created
* **ModifiedBy** (VARCHAR(255) - ):User who last modified the API token
* **ModifiedAt** (DATETIME - ):Date and time when the API token was last modified

## ApiTokenPolicies
Stores policies associated with API tokens, defining access permissions
### Fields
* **Id** (CHAR(36) - PRIMARY KEY):Unique identifier for the policy
* **ApiTokenId** (CHAR(36) - NOT NULL, FOREIGN KEY REFERENCES ApiTokens(Id) ON DELETE CASCADE):Foreign key referencing the associated API token
* **Area** (VARCHAR(255) - NOT NULL):Area or scope of the policy
* **Actions** (TEXT - NOT NULL):Actions allowed by this policy

## GlobalSettings
Stores global application settings
### Fields
* **Id** (CHAR(36) - PRIMARY KEY):Unique identifier for the global settings
* **SuperAdmins** (TEXT - ):Comma-separated list of super administrator user identifiers
* **CreatedBy** (VARCHAR(255) - NOT NULL):User who created the global settings
* **CreatedAt** (DATETIME - NOT NULL):Date and time when the global settings were created
* **ModifiedBy** (VARCHAR(255) - ):User who last modified the global settings
* **ModifiedAt** (DATETIME - ):Date and time when the global settings were last modified

## PluginDefinitions
Stores definitions for available plugins in the system
### Fields
* **Id** (CHAR(36) - PRIMARY KEY):Unique identifier for the plugin definition
* **Name** (VARCHAR(255) - NOT NULL):Name of the plugin
* **Category** (VARCHAR(255) - NOT NULL):Category of the plugin
* **Assembly** (VARCHAR(255) - NOT NULL):Assembly name where the plugin is implemented
* **Icon** (VARCHAR(255) - ):Icon identifier for the plugin
* **Description** (TEXT - ):Description of the plugin
* **Stylesheets** (TEXT - ):Stylesheets associated with the plugin
* **Locked** (TINYINT(1) - NOT NULL, DEFAULT 0):Indicates if the plugin definition is locked
* **CreatedBy** (VARCHAR(255) - NOT NULL):User who created the plugin definition
* **CreatedAt** (DATETIME - NOT NULL):Date and time when the plugin definition was created
* **ModifiedBy** (VARCHAR(255) - ):User who last modified the plugin definition
* **ModifiedAt** (DATETIME - ):Date and time when the plugin definition was last modified

## PluginDefinitionTypes
Stores types associated with plugin definitions
### Fields
* **Id** (CHAR(36) - PRIMARY KEY):Unique identifier for the plugin definition type
* **PluginDefinitionId** (CHAR(36) - NOT NULL, FOREIGN KEY REFERENCES PluginDefinitions(Id) ON DELETE CASCADE):Foreign key referencing the associated plugin definition
* **Name** (VARCHAR(255) - NOT NULL):Name of the plugin definition type
* **Type** (VARCHAR(255) - NOT NULL):Type identifier
* **IsDefault** (TINYINT(1) - NOT NULL, DEFAULT 0):Indicates if this is the default type for the plugin definition

## Sites
Stores information about websites or applications managed by the system
### Fields
* **Id** (CHAR(36) - PRIMARY KEY):Unique identifier for the site
* **Name** (VARCHAR(255) - NOT NULL):Name of the site
* **Description** (TEXT - ):Description of the site
* **Urls** (TEXT - ):Comma-separated list of URLs associated with the site
* **LayoutId** (CHAR(36) - NOT NULL):Identifier for the default layout of the site
* **DetailLayoutId** (CHAR(36) - NOT NULL):Identifier for the detail page layout
* **EditLayoutId** (CHAR(36) - NOT NULL):Identifier for the edit page layout
* **CreatedBy** (VARCHAR(255) - NOT NULL):User who created the site
* **CreatedAt** (DATETIME - NOT NULL):Date and time when the site was created
* **ModifiedBy** (VARCHAR(255) - ):User who last modified the site
* **ModifiedAt** (DATETIME - ):Date and time when the site was last modified

## Settings
Stores general settings configurations
### Fields
* **Id** (CHAR(36) - PRIMARY KEY):Unique identifier for the settings
* **CreatedBy** (VARCHAR(255) - NOT NULL):User who created the settings
* **CreatedAt** (DATETIME - NOT NULL):Date and time when the settings were created
* **ModifiedBy** (VARCHAR(255) - ):User who last modified the settings
* **ModifiedAt** (DATETIME - ):Date and time when the settings were last modified

## SettingValues
Stores individual setting values associated with settings configurations
### Fields
* **Id** (CHAR(36) - PRIMARY KEY):Unique identifier for the setting value
* **SettingsId** (CHAR(36) - NOT NULL, FOREIGN KEY REFERENCES Settings(Id) ON DELETE CASCADE):Foreign key referencing the associated settings configuration
* **Key** (VARCHAR(255) - NOT NULL):Key identifier for the setting value
* **Value** (TEXT - NOT NULL):Value of the setting

## Users
Stores user account information for authentication and authorization
### Fields
* **Id** (CHAR(36) - PRIMARY KEY):Unique identifier for the user
* **UserName** (VARCHAR(255) - ):Username for login
* **NormalizedUserName** (VARCHAR(255) - ):Normalized version of the username for case-insensitive lookups
* **Email** (VARCHAR(255) - ):Email address of the user
* **NormalizedEmail** (VARCHAR(255) - ):Normalized version of the email for case-insensitive lookups
* **EmailConfirmed** (TINYINT(1) - NOT NULL):Indicates if the user's email has been confirmed
* **PasswordHash** (TEXT - ):Hashed password for the user
* **SecurityStamp** (VARCHAR(255) - ):Security stamp for tracking security-related changes
* **ConcurrencyStamp** (VARCHAR(255) - ):Concurrency stamp for optimistic concurrency control
* **PhoneNumber** (VARCHAR(255) - ):Phone number of the user
* **PhoneNumberConfirmed** (TINYINT(1) - NOT NULL):Indicates if the user's phone number has been confirmed
* **TwoFactorEnabled** (TINYINT(1) - NOT NULL):Indicates if two-factor authentication is enabled for the user
* **LockoutEnd** (DATETIME - ):Date and time when the user lockout ends
* **LockoutEnabled** (TINYINT(1) - NOT NULL):Indicates if user lockout is enabled
* **AccessFailedCount** (INT - NOT NULL):Number of failed access attempts
* **LoginAt** (DATETIME - ):Date and time of the last login
* **LoginCount** (INT - NOT NULL):Total number of logins
* **PasswordChangedAt** (DATETIME - ):Date and time when the password was last changed
* **PasswordChangedBy** (VARCHAR(255) - ):User who last changed the password
* **Enabled** (TINYINT(1) - NOT NULL, DEFAULT 1):Indicates if the user account is enabled
* **CreatedBy** (VARCHAR(255) - NOT NULL):User who created this user account
* **CreatedAt** (DATETIME - NOT NULL):Date and time when the user account was created
* **ModifiedBy** (VARCHAR(255) - ):User who last modified this user account
* **ModifiedAt** (DATETIME - ):Date and time when the user account was last modified
* **AuthenticatorKey** (VARCHAR(255) - ):Key used for authenticator applications
* **FirstName** (VARCHAR(255) - ):First name of the user
* **LastName** (VARCHAR(255) - ):Last name of the user

## Roles
Stores role definitions for access control within sites
### Fields
* **Id** (CHAR(36) - PRIMARY KEY):Unique identifier for the role
* **SiteId** (CHAR(36) - NOT NULL, FOREIGN KEY REFERENCES Sites(Id) ON DELETE CASCADE):Foreign key referencing the associated site
* **Name** (VARCHAR(255) - NOT NULL):Name of the role
* **Description** (TEXT - ):Description of the role
* **Type** (INT - NOT NULL):Type of the role (represented as an enum value)
* **CreatedBy** (VARCHAR(255) - NOT NULL):User who created the role
* **CreatedAt** (DATETIME - NOT NULL):Date and time when the role was created
* **ModifiedBy** (VARCHAR(255) - ):User who last modified the role
* **ModifiedAt** (DATETIME - ):Date and time when the role was last modified

## Folders
Stores folder structures for organizing files within sites
### Fields
* **Id** (CHAR(36) - PRIMARY KEY):Unique identifier for the folder
* **SiteId** (CHAR(36) - NOT NULL, FOREIGN KEY REFERENCES Sites(Id) ON DELETE CASCADE):Foreign key referencing the associated site
* **Name** (VARCHAR(255) - NOT NULL):Name of the folder
* **NormalizedName** (VARCHAR(255) - NOT NULL):Normalized name of the folder for case-insensitive lookups
* **ParentId** (CHAR(36) - ):Identifier of the parent folder (for hierarchical structure)
* **CreatedBy** (VARCHAR(255) - NOT NULL):User who created the folder
* **CreatedAt** (DATETIME - NOT NULL):Date and time when the folder was created
* **ModifiedBy** (VARCHAR(255) - ):User who last modified the folder
* **ModifiedAt** (DATETIME - ):Date and time when the folder was last modified

## Files
Stores file information within the system
### Fields
* **Id** (CHAR(36) - PRIMARY KEY):Unique identifier for the file
* **SiteId** (CHAR(36) - NOT NULL, FOREIGN KEY REFERENCES Sites(Id) ON DELETE CASCADE):Foreign key referencing the associated site
* **Name** (VARCHAR(255) - NOT NULL):Name of the file
* **NormalizedName** (VARCHAR(255) - NOT NULL):Normalized name of the file for case-insensitive lookups
* **FolderId** (CHAR(36) - NOT NULL, FOREIGN KEY REFERENCES Folders(Id) ON DELETE CASCADE):Foreign key referencing the associated folder
* **Extension** (VARCHAR(10) - NOT NULL):File extension
* **ContentType** (VARCHAR(255) - NOT NULL):MIME type of the file
* **Size** (BIGINT - NOT NULL):Size of the file in bytes
* **CreatedBy** (VARCHAR(255) - NOT NULL):User who created the file
* **CreatedAt** (DATETIME - NOT NULL):Date and time when the file was created
* **ModifiedBy** (VARCHAR(255) - ):User who last modified the file
* **ModifiedAt** (DATETIME - ):Date and time when the file was last modified

## Blocks
Stores reusable content blocks for pages within sites
### Fields
* **Id** (CHAR(36) - PRIMARY KEY):Unique identifier for the block
* **SiteId** (CHAR(36) - NOT NULL, FOREIGN KEY REFERENCES Sites(Id) ON DELETE CASCADE):Foreign key referencing the associated site
* **Name** (VARCHAR(255) - NOT NULL):Name of the block
* **Category** (VARCHAR(255) - NOT NULL):Category of the block
* **Description** (TEXT - ):Description of the block
* **Content** (TEXT - NOT NULL):Content of the block
* **CreatedBy** (VARCHAR(255) - NOT NULL):User who created the block
* **CreatedAt** (DATETIME - NOT NULL):Date and time when the block was created
* **ModifiedBy** (VARCHAR(255) - ):User who last modified the block
* **ModifiedAt** (DATETIME - ):Date and time when the block was last modified

## Pages
Stores page information within sites
### Fields
* **Id** (CHAR(36) - PRIMARY KEY):Unique identifier for the page
* **SiteId** (CHAR(36) - NOT NULL, FOREIGN KEY REFERENCES Sites(Id) ON DELETE CASCADE):Foreign key referencing the associated site
* **Title** (VARCHAR(255) - NOT NULL):Title of the page
* **ParentId** (CHAR(36) - ):Identifier of the parent page (for hierarchical structure)
* **Order** (INT - NOT NULL):Display order of the page
* **Path** (VARCHAR(255) - NOT NULL):URL path of the page
* **LayoutId** (CHAR(36) - ):Identifier for the layout used by this page
* **EditLayoutId** (CHAR(36) - ):Identifier for the edit layout used by this page
* **DetailLayoutId** (CHAR(36) - ):Identifier for the detail layout used by this page
* **Locked** (TINYINT(1) - NOT NULL, DEFAULT 0):Indicates if the page is locked from editing
* **CreatedBy** (VARCHAR(255) - NOT NULL):User who created the page
* **CreatedAt** (DATETIME - NOT NULL):Date and time when the page was created
* **ModifiedBy** (VARCHAR(255) - ):User who last modified the page
* **ModifiedAt** (DATETIME - ):Date and time when the page was last modified


## Notes
The database schema shows a well-structured content management system with clear separation of concerns. Key relationships include: ApiTokens to ApiTokenPolicies (1:N), PluginDefinitions to PluginDefinitionTypes (1:N), Sites as a central entity connecting to Roles, Folders, Files, Blocks, and Pages (1:N relationships), and Settings to SettingValues (1:N). The schema uses CHAR(36) for GUID primary keys consistently across all tables. Several tables have audit fields (CreatedBy, CreatedAt, ModifiedBy, ModifiedAt) which is good for tracking changes. Indexes are created on foreign keys and frequently queried columns. Some potential normalization issues include storing comma-separated values in GlobalSettings.SuperAdmins and Sites.Urls fields, which could be normalized into separate tables for better query performance and data integrity. The use of TINYINT(1) for boolean values is consistent throughout. All tables use InnoDB engine which supports foreign key constraints.