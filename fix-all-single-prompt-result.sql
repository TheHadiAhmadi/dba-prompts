-- Table for ApiTokens
CREATE TABLE ApiTokens (
    Id CHAR(36) PRIMARY KEY, -- GUID as CHAR(36)
    Name VARCHAR(255) NOT NULL,
    Description NVARCHAR(1000),
    `Key` VARCHAR(255) NOT NULL UNIQUE,
    Secret VARCHAR(255) NOT NULL,
    ExpireAt DATETIME2,
    Enabled BIT NOT NULL DEFAULT 1, -- Boolean as BIT
    CreatedBy CHAR(36) NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    ModifiedBy CHAR(36),
    ModifiedAt DATETIME2,
    CONSTRAINT FK_ApiTokens_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES Users(Id),
    CONSTRAINT FK_ApiTokens_ModifiedBy FOREIGN KEY (ModifiedBy) REFERENCES Users(Id)
) ON [PRIMARY];

-- Table for Policies (related to ApiTokens)
CREATE TABLE ApiTokenPolicies (
    Id CHAR(36) PRIMARY KEY, -- GUID as CHAR(36)
    ApiTokenId CHAR(36) NOT NULL, -- Foreign key to ApiTokens
    Area VARCHAR(255) NOT NULL,
    Actions NVARCHAR(MAX) NOT NULL,
    CONSTRAINT FK_ApiTokenPolicies_ApiTokens FOREIGN KEY (ApiTokenId) REFERENCES ApiTokens(Id) ON DELETE CASCADE
) ON [PRIMARY];

CREATE NONCLUSTERED INDEX IX_ApiTokenPolicies_ApiTokenId ON ApiTokenPolicies (ApiTokenId);

-- Table for GlobalSettings
CREATE TABLE GlobalSettings (
    Id CHAR(36) PRIMARY KEY,
    CreatedBy CHAR(36) NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    ModifiedBy CHAR(36),
    ModifiedAt DATETIME2,
    CONSTRAINT FK_GlobalSettings_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES Users(Id),
    CONSTRAINT FK_GlobalSettings_ModifiedBy FOREIGN KEY (ModifiedBy) REFERENCES Users(Id)
) ON [PRIMARY];

-- Table for SuperAdmins (normalized from GlobalSettings)
CREATE TABLE SuperAdmins (
    Id CHAR(36) PRIMARY KEY,
    GlobalSettingsId CHAR(36) NOT NULL,
    UserId CHAR(36) NOT NULL,
    CONSTRAINT FK_SuperAdmins_GlobalSettings FOREIGN KEY (GlobalSettingsId) REFERENCES GlobalSettings(Id) ON DELETE CASCADE,
    CONSTRAINT FK_SuperAdmins_Users FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE CASCADE
) ON [PRIMARY];

CREATE NONCLUSTERED INDEX IX_SuperAdmins_GlobalSettingsId ON SuperAdmins (GlobalSettingsId);

-- Table for PluginDefinitions
CREATE TABLE PluginDefinitions (
    Id CHAR(36) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Category VARCHAR(255) NOT NULL,
    Assembly VARCHAR(255) NOT NULL,
    Icon VARCHAR(255), -- Nullable
    Description NVARCHAR(1000), -- Nullable
    Stylesheets NVARCHAR(1000), -- Nullable
    Locked BIT NOT NULL DEFAULT 0, -- Boolean as BIT
    CreatedBy CHAR(36) NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    ModifiedBy CHAR(36),
    ModifiedAt DATETIME2,
    CONSTRAINT FK_PluginDefinitions_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES Users(Id),
    CONSTRAINT FK_PluginDefinitions_ModifiedBy FOREIGN KEY (ModifiedBy) REFERENCES Users(Id)
) ON [PRIMARY];

-- Table for PluginDefinitionTypes
CREATE TABLE PluginDefinitionTypes (
    Id CHAR(36) PRIMARY KEY,
    PluginDefinitionId CHAR(36) NOT NULL, -- Foreign key to PluginDefinitions
    Name VARCHAR(255) NOT NULL,
    Type VARCHAR(255) NOT NULL,
    IsDefault BIT NOT NULL DEFAULT 0, -- Boolean as BIT
    CONSTRAINT FK_PluginDefinitionTypes_PluginDefinitions FOREIGN KEY (PluginDefinitionId) REFERENCES PluginDefinitions(Id) ON DELETE CASCADE
) ON [PRIMARY];

CREATE NONCLUSTERED INDEX IX_PluginDefinitionTypes_PluginDefinitionId ON PluginDefinitionTypes (PluginDefinitionId);

-- Table for Sites
CREATE TABLE Sites (
    Id CHAR(36) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Description NVARCHAR(1000),
    LayoutId CHAR(36) NOT NULL,
    DetailLayoutId CHAR(36) NOT NULL,
    EditLayoutId CHAR(36) NOT NULL,
    CreatedBy CHAR(36) NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    ModifiedBy CHAR(36),
    ModifiedAt DATETIME2,
    CONSTRAINT FK_Sites_LayoutId FOREIGN KEY (LayoutId) REFERENCES Pages(Id),
    CONSTRAINT FK_Sites_DetailLayoutId FOREIGN KEY (DetailLayoutId) REFERENCES Pages(Id),
    CONSTRAINT FK_Sites_EditLayoutId FOREIGN KEY (EditLayoutId) REFERENCES Pages(Id),
    CONSTRAINT FK_Sites_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES Users(Id),
    CONSTRAINT FK_Sites_ModifiedBy FOREIGN KEY (ModifiedBy) REFERENCES Users(Id)
) ON [PRIMARY];

-- Table for SiteUrls (normalized from Sites)
CREATE TABLE SiteUrls (
    Id CHAR(36) PRIMARY KEY,
    SiteId CHAR(36) NOT NULL,
    Url VARCHAR(2048) NOT NULL,
    CONSTRAINT FK_SiteUrls_Sites FOREIGN KEY (SiteId) REFERENCES Sites(Id) ON DELETE CASCADE
) ON [PRIMARY];

CREATE NONCLUSTERED INDEX IX_SiteUrls_SiteId ON SiteUrls (SiteId);

-- Table for Settings
CREATE TABLE Settings (
    Id CHAR(36) PRIMARY KEY, -- GUID as CHAR(36)
    CreatedBy CHAR(36) NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    ModifiedBy CHAR(36),
    ModifiedAt DATETIME2,
    CONSTRAINT FK_Settings_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES Users(Id),
    CONSTRAINT FK_Settings_ModifiedBy FOREIGN KEY (ModifiedBy) REFERENCES Users(Id)
) ON [PRIMARY];

-- Table for SettingValues
CREATE TABLE SettingValues (
    Id CHAR(36) PRIMARY KEY,
    SettingsId CHAR(36) NOT NULL, -- Foreign key to Settings
    `Key` VARCHAR(255) NOT NULL,
    `Value` NVARCHAR(MAX) NOT NULL,
    CONSTRAINT FK_SettingValues_Settings FOREIGN KEY (SettingsId) REFERENCES Settings(Id) ON DELETE CASCADE
) ON [PRIMARY];

CREATE NONCLUSTERED INDEX IX_SettingValues_SettingsId_Key ON SettingValues (SettingsId, `Key`);

-- Table for Users
CREATE TABLE Users (
    Id CHAR(36) PRIMARY KEY,
    UserName VARCHAR(255) UNIQUE,
    NormalizedUserName VARCHAR(255) UNIQUE,
    Email VARCHAR(255) UNIQUE,
    NormalizedEmail VARCHAR(255) UNIQUE,
    EmailConfirmed BIT NOT NULL,
    PasswordHash NVARCHAR(MAX),
    SecurityStamp VARCHAR(255),
    ConcurrencyStamp VARCHAR(255),
    PhoneNumber VARCHAR(255),
    PhoneNumberConfirmed BIT NOT NULL,
    TwoFactorEnabled BIT NOT NULL,
    LockoutEnd DATETIME2,
    LockoutEnabled BIT NOT NULL,
    AccessFailedCount INT NOT NULL,
    LoginAt DATETIME2,
    LoginCount INT NOT NULL,
    PasswordChangedAt DATETIME2,
    PasswordChangedBy CHAR(36),
    Enabled BIT NOT NULL DEFAULT 1,
    CreatedBy CHAR(36) NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    ModifiedBy CHAR(36),
    ModifiedAt DATETIME2,
    AuthenticatorKey VARCHAR(255),
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    CONSTRAINT FK_Users_PasswordChangedBy FOREIGN KEY (PasswordChangedBy) REFERENCES Users(Id),
    CONSTRAINT FK_Users_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES Users(Id),
    CONSTRAINT FK_Users_ModifiedBy FOREIGN KEY (ModifiedBy) REFERENCES Users(Id)
) ON [PRIMARY];

CREATE NONCLUSTERED INDEX IX_Users_UserName_Email ON Users (UserName, Email);

-- Table for Roles
CREATE TABLE Roles (
    Id CHAR(36) PRIMARY KEY,
    SiteId CHAR(36) NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Description NVARCHAR(1000),
    Type INT NOT NULL, -- Enum as INT
    CreatedBy CHAR(36) NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    ModifiedBy CHAR(36),
    ModifiedAt DATETIME2,
    CONSTRAINT FK_Roles_Sites FOREIGN KEY (SiteId) REFERENCES Sites(Id) ON DELETE CASCADE,
    CONSTRAINT FK_Roles_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES Users(Id),
    CONSTRAINT FK_Roles_ModifiedBy FOREIGN KEY (ModifiedBy) REFERENCES Users(Id)
) ON [PRIMARY];

CREATE NONCLUSTERED INDEX IX_Roles_SiteId_Name ON Roles (SiteId, Name);

-- Table for Folders
CREATE TABLE Folders (
    Id CHAR(36) PRIMARY KEY,
    SiteId CHAR(36) NOT NULL,
    Name VARCHAR(255) NOT NULL,
    NormalizedName VARCHAR(255) NOT NULL,
    ParentId CHAR(36),
    CreatedBy CHAR(36) NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    ModifiedBy CHAR(36),
    ModifiedAt DATETIME2,
    CONSTRAINT FK_Folders_Sites FOREIGN KEY (SiteId) REFERENCES Sites(Id) ON DELETE CASCADE,
    CONSTRAINT FK_Folders_ParentId FOREIGN KEY (ParentId) REFERENCES Folders(Id),
    CONSTRAINT FK_Folders_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES Users(Id),
    CONSTRAINT FK_Folders_ModifiedBy FOREIGN KEY (ModifiedBy) REFERENCES Users(Id)
) ON [PRIMARY];

CREATE NONCLUSTERED INDEX IX_Folders_SiteId_Name ON Folders (SiteId, Name);

-- Table for Files
CREATE TABLE Files (
    Id CHAR(36) PRIMARY KEY,
    SiteId CHAR(36) NOT NULL,
    Name VARCHAR(255) NOT NULL,
    NormalizedName VARCHAR(255) NOT NULL,
    FolderId CHAR(36) NOT NULL,
    Extension VARCHAR(10) NOT NULL,
    ContentType VARCHAR(255) NOT NULL,
    Size BIGINT NOT NULL,
    CreatedBy CHAR(36) NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    ModifiedBy CHAR(36),
    ModifiedAt DATETIME2,
    CONSTRAINT FK_Files_Sites FOREIGN KEY (SiteId) REFERENCES Sites(Id) ON DELETE CASCADE,
    CONSTRAINT FK_Files_Folders FOREIGN KEY (FolderId) REFERENCES Folders(Id) ON DELETE CASCADE,
    CONSTRAINT FK_Files_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES Users(Id),
    CONSTRAINT FK_Files_ModifiedBy FOREIGN KEY (ModifiedBy) REFERENCES Users(Id)
) ON [PRIMARY];

CREATE NONCLUSTERED INDEX IX_Files_SiteId_Name ON Files (SiteId, Name);

-- Table for Blocks
CREATE TABLE Blocks (
    Id CHAR(36) PRIMARY KEY,
    SiteId CHAR(36) NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Category VARCHAR(255) NOT NULL,
    Description NVARCHAR(1000),
    Content NVARCHAR(MAX) NOT NULL,
    CreatedBy CHAR(36) NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    ModifiedBy CHAR(36),
    ModifiedAt DATETIME2,
    CONSTRAINT FK_Blocks_Sites FOREIGN KEY (SiteId) REFERENCES Sites(Id) ON DELETE CASCADE,
    CONSTRAINT FK_Blocks_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES Users(Id),
    CONSTRAINT FK_Blocks_ModifiedBy FOREIGN KEY (ModifiedBy) REFERENCES Users(Id)
) ON [PRIMARY];

CREATE NONCLUSTERED INDEX IX_Blocks_SiteId_Name ON Blocks (SiteId, Name);

-- Table for Pages
CREATE TABLE Pages (
    Id CHAR(36) PRIMARY KEY,
    SiteId CHAR(36) NOT NULL,
    Title VARCHAR(255) NOT NULL,
    ParentId CHAR(36),
    `Order` INT NOT NULL,
    Path VARCHAR(255) NOT NULL,
    LayoutId CHAR(36),
    EditLayoutId CHAR(36),
    DetailLayoutId CHAR(36),
    Locked BIT NOT NULL DEFAULT 0,
    CreatedBy CHAR(36) NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    ModifiedBy CHAR(36),
    ModifiedAt DATETIME2,
    CONSTRAINT FK_Pages_Sites FOREIGN KEY (SiteId) REFERENCES Sites(Id) ON DELETE CASCADE,
    CONSTRAINT FK_Pages_ParentId FOREIGN KEY (ParentId) REFERENCES Pages(Id),
    CONSTRAINT FK_Pages_LayoutId FOREIGN KEY (LayoutId) REFERENCES Pages(Id),
    CONSTRAINT FK_Pages_EditLayoutId FOREIGN KEY (EditLayoutId) REFERENCES Pages(Id),
    CONSTRAINT FK_Pages_DetailLayoutId FOREIGN KEY (DetailLayoutId) REFERENCES Pages(Id),
    CONSTRAINT FK_Pages_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES Users(Id),
    CONSTRAINT FK_Pages_ModifiedBy FOREIGN KEY (ModifiedBy) REFERENCES Users(Id)
) ON [PRIMARY];

CREATE NONCLUSTERED INDEX IX_Pages_SiteId_Path ON Pages (SiteId, Path);