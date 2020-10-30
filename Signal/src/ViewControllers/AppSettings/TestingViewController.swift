//
//  Copyright (c) 2020 Open Whisper Systems. All rights reserved.
//

import Foundation

@objc
class TestingViewController: OWSTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        title = LocalizationNotNeeded("Testing")

        self.useThemeBackgroundColors = true

        updateTableContents()
    }

    func updateTableContents() {
        let contents = OWSTableContents()

        do {
            let section = OWSTableSection()
            section.footerTitle = LocalizationNotNeeded("These values are temporary and will reset on next launch of the app.")
            contents.addSection(section)
        }

        do {
            let section = OWSTableSection()
            section.footerTitle = LocalizationNotNeeded("This will reset all of these flags to their default values.")
            section.add(OWSTableItem.actionItem(withText: LocalizationNotNeeded("Reset all testable flags.")) { [weak self] in
                NotificationCenter.default.post(name: TestableFlag.ResetAllTestableFlagsNotification, object: nil)
                self?.updateTableContents()
            })
            contents.addSection(section)
        }

        func buildSwitchItem(title: String, testableFlag: TestableFlag) -> OWSTableItem {
            OWSTableItem.switch(withText: title,
                                isOn: { testableFlag.get() },
                                target: testableFlag,
                                selector: testableFlag.switchSelector)
        }

        do {
            let section = OWSTableSection()
            section.footerTitle = LocalizationNotNeeded("The app will not send 'group update' messages for v2 groups. " +
            "Other group members will only learn of group changes from normal group messages.")
            section.add(buildSwitchItem(title: LocalizationNotNeeded("Groups v2: Don't Send Updates"),
                                        testableFlag: DebugFlags.groupsV2dontSendUpdates))
            contents.addSection(section)
        }

        do {
            let section = OWSTableSection()
            section.footerTitle = LocalizationNotNeeded("Members added to a v2 group will always be invited instead of added.")
            section.add(buildSwitchItem(title: LocalizationNotNeeded("Groups v2: Always Invite"),
                                        testableFlag: DebugFlags.groupsV2forceInvites))
            contents.addSection(section)
        }

        do {
            let section = OWSTableSection()
            section.footerTitle = LocalizationNotNeeded("Client will only emit corrupt invites to v2 groups.")
            section.add(buildSwitchItem(title: LocalizationNotNeeded("Groups v2: Corrupt Invites"),
                                        testableFlag: DebugFlags.groupsV2corruptInvites))
            contents.addSection(section)
        }

        do {
            let section = OWSTableSection()
            section.footerTitle = LocalizationNotNeeded("Client will not try to create v2 groups.")
            section.add(buildSwitchItem(title: LocalizationNotNeeded("Groups v2: Only create v1 groups"),
                                        testableFlag: DebugFlags.groupsV2onlyCreateV1Groups))
            contents.addSection(section)
        }

        do {
            let section = OWSTableSection()
            section.footerTitle = LocalizationNotNeeded("Client will update group state with corrupt blobs.")
            section.add(buildSwitchItem(title: LocalizationNotNeeded("Groups v2: Corrupt blobs"),
                                        testableFlag: DebugFlags.groupsV2corruptBlobEncryption))
            contents.addSection(section)
        }

        do {
            let section = OWSTableSection()
            section.footerTitle = LocalizationNotNeeded("Client will update group state with corrupt avatar URL paths.")
            section.add(buildSwitchItem(title: LocalizationNotNeeded("Groups v2: Corrupt avatar URL paths"),
                                        testableFlag: DebugFlags.groupsV2corruptAvatarUrlPaths))
            contents.addSection(section)
        }

        do {
            let section = OWSTableSection()
            section.footerTitle = LocalizationNotNeeded("Client will allow manual and auto-migrations.")
            section.add(buildSwitchItem(title: LocalizationNotNeeded("Groups v2: Force enable migrations"),
                                        testableFlag: DebugFlags.groupsV2migrationsForceEnable))
            contents.addSection(section)
        }

        do {
            let section = OWSTableSection()
            section.footerTitle = LocalizationNotNeeded("Client will not auto-migrate legacy groups to new groups.")
            section.add(buildSwitchItem(title: LocalizationNotNeeded("Groups v2: Disable auto-migrations"),
                                        testableFlag: DebugFlags.groupsV2migrationsDisableAutomigrations))
            contents.addSection(section)
        }

        do {
            let section = OWSTableSection()
            section.footerTitle = LocalizationNotNeeded("Group migrations will drop other members.")
            section.add(buildSwitchItem(title: LocalizationNotNeeded("Groups v2: Migrations drop others"),
                                        testableFlag: DebugFlags.groupsV2migrationsDropOtherMembers))
            contents.addSection(section)
        }

        do {
            let section = OWSTableSection()
            section.footerTitle = LocalizationNotNeeded("Group migrations will invite other members.")
            section.add(buildSwitchItem(title: LocalizationNotNeeded("Groups v2: Migrations invite others"),
                                        testableFlag: DebugFlags.groupsV2migrationsInviteOtherMembers))
            contents.addSection(section)
        }

        do {
            let section = OWSTableSection()
            section.footerTitle = LocalizationNotNeeded("The app will pretend not to support group migrations.")
            section.add(buildSwitchItem(title: LocalizationNotNeeded("Groups v2: Disable Migration Capability"),
                                        testableFlag: DebugFlags.groupsV2migrationsDisableMigrationCapability))
            contents.addSection(section)
        }

        do {
            let section = OWSTableSection()
            section.footerTitle = LocalizationNotNeeded("Group migrations will proceed even if some members will be dropped.")
            section.add(buildSwitchItem(title: LocalizationNotNeeded("Groups v2: Force Aggressive Migrations"),
                                        testableFlag: DebugFlags.groupsV2migrationsForceAggressive))
            contents.addSection(section)
        }

        do {
            let section = OWSTableSection()
            section.footerTitle = LocalizationNotNeeded("Client will store but not process incoming messages.")
            section.add(buildSwitchItem(title: LocalizationNotNeeded("Disable message processing"),
                                        testableFlag: DebugFlags.disableMessageProcessing))
            contents.addSection(section)
        }

        do {
            let section = OWSTableSection()
            section.footerTitle = LocalizationNotNeeded("Client will update profiles aggressively.")
            section.add(buildSwitchItem(title: LocalizationNotNeeded("Aggressive profile fetching"),
                                        testableFlag: DebugFlags.aggressiveProfileFetching))
            contents.addSection(section)
        }

        self.contents = contents
    }
}
