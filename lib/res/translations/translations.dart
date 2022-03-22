import 'package:get/get_navigation/src/root/internacionalization.dart';

class MiniMaxTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    return {
      'en': {
        'generalNetworkTitleError': 'Error',
        'generalNetworkMessageError': 'There\'s been an error, please try again later.',
        'homeSetUpYourPhone': 'Let’s set up your phone',
        'homeCTATitle': 'Continue',
        'backgroundCheckTitle': 'Battery Permissions',
        'backgroundCheckExplanation': 'Waiting for your confirmation to accept to run Minima in the background…',
        'backgroundCheckBackToBatterySettingsCTA': 'Back to battery settings',
        'batterySettingsTitle': 'Battery Settings',
        'batterySettingsExplanation':
        """<b>For Minima to function properly, the app needs to run in the background on your device.</b><br><br>Please grant permission using the <b>Confirm</b> button below.""",
        'batterySettingsConfirm': 'Confirm',
        'batterySettingsSkip': 'Skip',
        'backgroundRunningTitle': 'Minima',
        'backgroundRunningBigTitle': 'Background running',
        'backgroundRunningBigTitleMinimaBackground': 'Minima must run in the background',
        'backgroundRunningExplanation2': 'Are you sure you want to skip this stage?',
        'backgroundRunningExplanation3':
        'For Minima to function as expected, it must be allowed to run in the background.<p>You can change this setting later by choosing Battery Optimization from the side navigation menu in the app.',
        'backgroundRunningCTAYes': 'Yes',
        'backgroundRunningCTANo': 'No',
        'backupExplanationTitle': 'Backup',
        'backupExplanationTextSplit1': 'Once your app has loaded, navigate to the Options menu and choose ',
        'backupExplanationTextSplit2': 'BACKUP',
        'backupExplanationTextSplit3': '.\nYou can ',
        'backupExplanationTextSplit4': 'RESTORE',
        'backupExplanationTextSplit5': ' your backup from the Options menu as well.\n\nAfter clicking ',
        'backupExplanationTextSplit6': 'BACKUP',
        'backupExplanationTextSplit7':
        ', please wait for your backup file to be created. Your phone will then ask you where to save it.',
        'backupExplanationCTA': 'Continue',
        'incentiveExplanationTitle': 'Incentive Program',
        'incentiveExplanationText':
        """The Incentive Program is designed to reward you for running a Minima node.<p>You will receive one Reward every day your node pings us to let us know it is connected.<p><b>To claim your existing Rewards and to receive future Daily Rewards, be sure to set up your account on the Incentive Program page.</b>""",
        'incentiveCashExplanationCTA': 'Continue',
        'congratulationsTitle': 'Congratulations',
        'congratulationsExplanationSplit1': 'You are now ready to start using Minima.\n\n\n',
        'congratulationsCTA': 'Continue',
        'syncScreenSyncingText': 'Synchronising,  please wait…',
        'syncScreenGreetingText': 'Greeting received',
        'syncScreenLaunchCTA': 'Launch',
        'homeScreenDrawerHeaderVersion': 'Minima v%s',
        'homeScreenDrawerTitleNodeStatus': 'Node Status',
        'homeScreenDrawerTitleIncentiveCash': 'Incentive Program',
        'homeScreenDrawerTitleRewards': 'Rewards',
        'homeScreenDrawerTitleNewsFeed': 'News Feed',
        'homeScreenDrawerTitleBatteryOptimisation': 'Battery Optimization',
        'homeScreenDrawerTitleTerminal': 'Terminal',
        'homeScreenDrawerTitleHelp': 'Help',
        'newsCardReadLess': 'Show Less…',
        'newsCardReadMore': 'Show More…',
        'incentiveCashScreenIncentiveProgramTab': 'Incentive Program',
        'incentiveCashScreenInviteCodeTab': 'Invite Link',
        'incentiveCashScreenBalanceTab': 'Rewards',
        'incentiveCashScreenSetUpTextFieldTitle': 'Incentive ID',
        'incentiveCashScreenSetUpTextFieldHint': 'Enter Incentive ID',
        'incentiveCashScreenSetUpTextFieldEnterFirstTime': 'Enter',
        'incentiveCashScreenSetUpTextFieldEnterUpdate': 'Update',
        'incentiveCashScreenIncentiveCashProgramTitle': 'Set-Up Instructions',
        'incentiveCashScreenIncentiveCashProgramExplanationWithoutNodeId': """To start receiving Rewards, you must enter your Incentive ID into the field below.<p><p><ul> <li>If you know your Incentive ID, please enter it.</li><li>If you do not know your Incentive ID, please register or login to the Incentive Program website using the button below.</li></ul>""",
        'incentiveCashScreenSetUpTextFieldEnterUpdateLocked': 'Update (locked)',
        'incentiveCashScreenIncentiveCashProgramExplanationWithNodeId': "If you need to find your Incentive ID again, please use the button below.",
        'incentiveCashScreenIncentiveCashProgramCTA': 'Incentive Program Website',
        'incentiveCashScreenIncentiveCashProgramCTAUrl': 'https://incentive.minima.global/',
        'inviteCodeExplanationCodeEntered': 'Your Invite Link enables you to earn additional Rewards for inviting others to run a node and join the Incentive Program.<p>Once the Minima network reaches one million nodes, your Invite Link will no longer be active.',
        'inviteCodeExplanation': 'Your Invite Link enables you to earn additional Rewards for inviting others to run a node and join the Incentive Program.<p>Once the Minima network reaches one million nodes, your Invite Link will no longer be active.<p><b>In order to receive your Invite Link, you must connect your Incentive ID to your node using the Incentive Program tab above.</b>',
        'inviteCodeShareCTA': 'Share Invite Link',
        'inviteCodeTextFormTitle': 'Invite Link',
        'inviteCodeCopiedSnackbarTitle': 'Invite link',
        'inviteCodeCopiedSnackbarMessage': 'Code copied to your clipboard',
        'inviteCodeMessageToCopyToClipboard': 'Hey! You can earn Rewards for running a node on the Minima network. 😊\n\nRegister via my Invite Link:\nhttps://incentive.minima.global/account/register?inviteCode=%s\n\nThen get your node set up & join the community:\nhttps://discord.gg/minima',
        'inviteCodeLink': 'https://incentive.minima.global/account/register?inviteCode=%s',
        'inviteCodeShareTitle': 'Join Minima with me',
        'incentiveCashScreenBalancePingTitle': 'Last Ping:',
        'incentiveCashScreenBalancePingDateFormat1': "EEE dd MMM yyyy '|'",
        'incentiveCashScreenBalancePingDateFormat2': " HH:mm:ss '%s'",
        'incentiveCashScreenBalanceStatusConnected': 'Connected',
        'incentiveCashScreenBalanceStatusNotConnected': 'Not connected',
        'incentiveCashScreenBalanceStatusOffline': 'Offline',
        'helpScreenCommunityTab': 'Community',
        'helpScreenCommunityDev': 'Dev',
        'helpScreenCommunityTechPapers': 'Tech papers',
        'helpScreenTileCommunityWiki': 'Community Wiki',
        'helpScreenTileDiscord': 'Discord',
        'helpScreenTileTelegram': 'Telegram',
        'helpScreenTileTwitter': 'Twitter',
        'helpScreenTileYoutube': 'Youtube',
        'helpScreenTileWebsite': 'Website',
        'helpScreenTileBlogs': 'Blogs',
        'helpScreenTileGithub': 'Github',
        'helpScreenTileMinimaWhitePaper': 'Minima Whitepaper',
        'helpScreenTileTokenomicsPaper': 'Tokenomics Paper',
        'helpScreenTileProtocolLayers': 'Protocol Layers',
        'helpScreenLinkCommunityWiki': 'https://docs.minima.global/',
        'helpScreenLinkDiscord': 'https://discord.gg/minima',
        'helpScreenLinkTelegram': 'https://t.me/Minima_Global',
        'helpScreenLinkTwitter': 'https://twitter.com/Minima_Global',
        'helpScreenLinkWebsite': 'https://minima.global/',
        'helpScreenLinkBlogs': 'https://minima.global/blog#blogintro',
        'helpScreenLinkYoutube': 'https://www.youtube.com/channel/UCDe2j57uQrUVtVizFbDpsoQ/videos',
        'helpScreenLinkGithub': 'https://github.com/minima-global',
        'helpScreenLinkMinimaWhitePaper': 'https://docs.minima.global/minima_pdfs/Minima_Whitepaper_v10.pdf',
        'helpScreenLinkTokenomicsPaper': 'https://docs.minima.global/minima_pdfs/Minima_Token_Economics_2022.pdf',
        'helpScreenLinkProtocolLayers': 'https://docs.minima.global/minima_pdfs/Protocol_Layers_2022.pdf',
        'pdfReaderPagesOfD': 'of %d',
        'pdfReaderCantLoadPdfError': 'Can\'t load the Pdf',
        'terminalScreenContinueWarningCTA': 'Continue',
        'terminalScreenWarning': '<b>Please do not copy and paste your logs into Minima’s public channels.</b><p>If you need help, please head to #support on our Discord.<p>Thanks for your cooperation. 🙏',
        'terminalScreenTextFieldHint': 'Enter command',
        'nodeStatusTitle': 'Node Status:',
        'nodeStatusExplanation':
        'You can check that your Minima node is connected to the Minima network via the status bar below. If your node is successfully connected, your status will be shown as ‘Connected’ and a green light will be seen.<p>If your Node Status is showing as ‘Offline’ along with a red light, your node is currently not connected to the Minima network. In the event that this occurs, please follow the instructions below the status bar to help you get reconnected.</p>',
        'nodeStatusCardTitle': 'Node Status: ',
        'nodeStatusCardInactiveActionRequired':
        """<ol><li>Check your device is connected to the internet.</li><li>Check your device is running Android version 9 or above.</li><li>Check your battery settings are set to allow Minima to run in the background.</li><li>Check that you are running the latest version of the Minima app.</li><li>Try restarting your node by quitting the app and and reopening it.</li></ol><p>If Minima still fails to work, please head to our Discord and create a ticket in the #support channel.</p>
        """,
        'incentiveCashCardTitle': 'Incentive ID: ',
        'batteryOptimisationCardTitle': 'Battery Optimization: ',
        'batteryOptimisationCardActionRequired':
        """To fully validate and secure the Minima blockchain, the protocol needs to run in the background. Use the link below to change your device settings.<p><a href="">Battery Optimization</a>""",
        'incentiveCashCardInactiveActionRequired':
        'Your node has no Incentive ID connected to it. To set this up, navigate to the Incentive Program page.',
        'statusCardActionRequiredTitle': 'Action required:',
        'apkCardTitle': 'APK Version : ',
        'nodeStatusLoading': 'Connecting…',
        'apkCardInactiveActionRequired':
        'You are not running the latest version of the Minima app, you can find the latest version on our Get-Started page:<p><a href="https://minima.global/get-started">https://minima.global/get-started</a>',
        'apkCardStatusUpToDate': 'Up to date',
        'apkCardStatusOutOfDate': 'Out of date',
        'allDoneScreenCloseCTA': 'Close',
        'allDoneScreenTitle': 'Incentive Program',
        'allDoneScreenBigTitle': 'All done!',
        'allDoneScreenContent':
        'You will receive one Reward every day your node pings us to let us know it is connected. <p>Rewards will be converted to Minima coins at Mainnet launch on a one for one basis.',
        'batteryOptimisationCTA': 'Battery optimization settings',
        'batteryOptimisationExplanation':
        'To fully validate and secure the Minima blockchain, the Minima protocol needs to run in the background.\n\nPlease use the button below to navigate to your phone\'s battery optimization settings and grant permission for Minima to run in the background.',
        'permissionsEnabledTitle': 'Battery Permissions',
        'permissionsEnabledMainTitle': 'Permissions enabled',
        'permissionsEnabledExplanation': 'Thanks!<p>Minima will now run in the background.',
        'permissionsEnabledCTA': 'Continue',
        'deciderMainContent': 'Empowering Freedom',
        'mgmExplanationMainContent':
        'The Minima Member get member program rewards users for<br><br><b>To claim your existing rewards and to earn future daily rewards, be sure to set up your account on the Incentive Program page.</b>',
        'mgmExplanationCta': 'Continue',
        'mgmExplanationTitle': 'Member get member',
        'loaderScreenLoading': 'Connecting, please wait…',
        'incentiveCashFirstScreenTitle': 'Welcome to the Incentive Program',
        'incentiveCashFirstScreenExplanation': """
      The Incentive Program is designed to reward you for running a Minima node.
      <p>You will receive one Reward every day your node pings us to let us know it is connected.</p>
      <p>Rewards will be converted to Minima coins at Mainnet launch on a one for one basis.</p>
      <p>Press continue to set up your Incentive Program account.</p>
      """,
        'incentiveCashFirstScreenContinueCTA': 'Continue',
        'rewardsTab': 'Rewards',
        'rewardsInfoTab': 'Rewards Info',
        'rewardsTabTotalRewardsTitle': 'Total Rewards',
        'rewardsTabBreakdownOfRewards': 'Breakdown of Rewards',
        'rewardsTabDailyNodeRewardsTitle': 'Total Daily Node Rewards',
        'rewardsTabInviteRewardsTitle': 'Total Invite Rewards',
        'rewardsTabAdditionalRewardsTitle': 'Total Additional Rewards',
        'rewardsInfoDailyRewardsTitle': 'Daily Node Rewards',
        'rewardsInfoDailyRewardsExplanation': 'You will earn 1 Reward each day your node is successfully connected to the network. Any Rewards earned before the Dec 21 Hard Fork are included in this total.',
        'rewardsInfoInviteRewardTitle': 'Invite Rewards',
        'rewardsInfoInviteRewardExplanation': 'For every person who registers using your Invite Link, you will earn an additional Reward of 0.1, each day their node is connected to the network.<p>As an example, if you invite your friends & they run a node for 100 days, this is what <b>you could earn:</b>',
        'rewardsInfoAdditionalRewardsTitle': 'Additional Rewards',
        'rewardsInfoAdditionalRewardsExplanation': 'You can earn additional Rewards for:<p><ul><li>Bug Reports</li><li>Bounty Rewards</li><li>Strategic Grants</li><li>Developer Grants</li><li>Prizes</li>',
        'rewardsInfoSPeople': 'Invite %s friends',
        'rewardsInfoSRewards': 'Earn %s Rewards',
        'regularNotificationsChannel': 'Regular notifications',
        'updatesNotificationsChannel': 'Notifications from updates',
      }
    };
  }
}
