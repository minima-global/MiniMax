import 'package:get/get_navigation/src/root/internacionalization.dart';

class MiniMaxTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    return {
      'en': {
        'generalNetworkTitleError': 'Error',
        'generalNetworkMessageError': 'There\'s been an error, please try again later.',
        'homeWelcomeTitle': 'Welcome to',
        'homeMinimaSentence': 'The complete blockchain solution',
        'homeSetUpYourPhone': 'Let’s set up your phone',
        'homeCTATitle': 'Continue',
        'batterySettingsTitle': 'Battery Settings',
        'batterySettingsExplanation':
            'To fully validate and secure the Minima blockchain, the Minima protocol needs to run in the background.\nPlease grant permission by clicking allow.\nIf you do not wish to do this now, you can change this setting later by choosing Battery Optimisation from the Options menu in the app.',
        'batterySettingsConfirm': 'Confirm',
        'batterySettingsSkip': 'Skip',
        'backgroundRunningTitle': 'Minima',
        'backgroundRunningBigTitle': 'Background running',
        'backgroundRunningBigTitleAreYouSure': 'Are you sure?',
        'backgroundRunningExplanation1':
            'Allowing Minima to run in the background may reduce battery life.\n\nPlease confirm that you allow Minima permission to run in the background.',
        'backgroundRunningExplanation2': 'Are you sure you want to skip this stage?',
        'backgroundRunningExplanation3':
            'For Minima to function as expected, it must be allowed to run in the background. You can change this setting later by choosing Battery Optimisation from the side navigation menu in the app.',
        'backgroundRunningCTAConfirm': 'Confirm',
        'backgroundRunningCTASkip': 'Deny',
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
        'incentiveExplanationTitle': 'IncentiveCash',
        'incentiveExplanationText':
            'Minima is currently in ‘Beta’ test net.\n\nWe are running an Incentive program for you to get Minima coins for running the app until we launch at main net.\n\nTo claim your existing rewards and to receive future daily rewards, be sure to set up your account on the IncentiveCash page.',
        'incentiveCashExplanationCTA': 'Continue',
        'congratulationsTitle': 'Congratulations',
        'congratulationsExplanationSplit1': 'You are now ready to start using Minima.\n\n\n',
        'congratulationsExplanationSplit2': 'A new world of Freedom awaits you.',
        'congratulationsCTA': 'Continue',
        'syncScreenSyncingText': 'Synchronising,  please wait…',
        'syncScreenGreetingText': 'Greeting received',
        'syncScreenLaunchCTA': 'Launch',
        'homeScreenDrawerBackUpNodeCTA': 'Back up Node',
        'homeScreenDrawerHeaderVersion': 'Minima v%s',
        'homeScreenDrawerTitleNodeStatus': 'Node Status',
        'homeScreenDrawerTitleIncentiveCash': 'IncentiveCash',
        'homeScreenDrawerTitleNewsFeed': 'News Feed',
        'homeScreenDrawerTitleBatteryOptimisation': 'Battery Optimisation',
        'homeScreenDrawerTitleTerminal': 'Terminal',
        'homeScreenDrawerTitleHelp': 'Help',
        'incentiveCashScreenSetUpTab': 'Set-up instructions',
        'incentiveCashScreenBalanceTab': 'Balance',
        'incentiveCashScreenSetUpTextFieldTitle': 'IncentiveCash NodeID',
        'incentiveCashScreenSetUpTextFieldHint': 'Enter IncentiveCash NodeID',
        'incentiveCashScreenSetUpTextFieldEnterFirstTime': 'Enter',
        'incentiveCashScreenSetUpTextFieldEnterUpdate': 'Update',
        'incentiveCashScreenIncentiveCashProgramTitle': 'The IncentiveCash Program:',
        'incentiveCashScreenIncentiveCashProgramExplanation':
            'The Minima IncentiveCash Program is designed to reward our users for running a Minima node. Users will receive one IncentiveCash token for every day your node pings us to let us know it is connected. IncentiveCash Tokens will be redeemable for Minima coins at mainnet launch on a one for one basis. In order to join the Minima IncentiveCash Program, you must enter your unique IncentiveCash NodeID in to the field below.  This can be found by logging in or registering to the IncentiveCash website. If you already have your IncentiveCash NodeID, please enter it below. If you do not have your IncentiveCash NodeID, Please use the button below to navigate to the IncentiveCash website.',
        'incentiveCashScreenIncentiveCashProgramCTA': 'IncentiveCash Website',
        'incentiveCashScreenIncentiveCashProgramCTAUrl': 'https://incentivecash.minima.global/',
        'incentiveCashScreenBalanceTitle': 'Incentive Cash Token Balance:',
        'incentiveCashScreenBalancePingTitle': 'Ping (Last sent):',
        'incentiveCashScreenBalancePingDateFormat1': "EEE dd MMM yyyy '/'",
        'incentiveCashScreenBalancePingDateFormat2': " HH:mm:ss '%s'",
        'incentiveCashScreenBalanceExplanation':
            'A ping is sent to the Minima network once at day at random. Please check that it is up to date.',
        'incentiveCashScreenBalanceStatusConnected': 'Connected',
        'incentiveCashScreenBalanceStatusNotConnected': 'Not Connected',
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
        'helpScreenLinkCommunityWiki': 'https://minima.global/community-wiki',
        'helpScreenLinkDiscord': 'https://discord.gg/minima',
        'helpScreenLinkTelegram': 'https://t.me/Minima_Global',
        'helpScreenLinkTwitter': 'https://twitter.com/Minima_Global',
        'helpScreenLinkWebsite': 'https://minima.global/',
        'helpScreenLinkBlogs': 'https://minima.global/blog#blogintro',
        'helpScreenLinkYoutube': 'https://www.youtube.com/channel/UCDe2j57uQrUVtVizFbDpsoQ/videos',
        'helpScreenLinkGithub': 'https://github.com/minima-global',
        'helpScreenLinkMinimaWhitePaper': 'https://cdn.minima.global/media/2021/07/02/Minima_Whitepaper_v9.pdf',
        'helpScreenLinkTokenomicsPaper':
            'https://cdn.minima.global/media/2021/11/16/Minima_Token_Economics_Aug2021-1.pdf',
        'helpScreenLinkProtocolLayers': 'https://cdn.minima.global/media/2021/07/02/Protocol_Layers_.pdf',
        'pdfReaderPagesOfD': 'of %d',
        'pdfReaderCantLoadPdfError': 'Can\'t load the Pdf',
        'terminalScreenTextFieldTitle': 'Enter Minima Command:',
        'terminalScreenTextFieldHint': 'Enter the command here…',
        'terminalScreenClearConsole': 'Clear console',
        'nodeStatusTitle': 'Node Status:',
        'nodeStatusExplanation': 'You can check that your Minima node is connected to the Minima network via the status bar below. If your node is successfully connected, your status will be shown as ‘connected’ and a green light will be seen.\nIf your node Status is showing as ‘Offline’ along with a red light, your node is currently not connected to the Minima network. In the event that this occurs, please follow the instructions below the status bar to help you get reconnected.',
        'nodeStatusCardTitle': 'Node Status : ',
        'nodeStatusCardInactiveActionRequired': 'Your node seems to be offline, here are some tips and tricks to help you get you back online. Please follow the instructions below.\nHere is an instruction.',
        'incentiveCashCardTitle': 'IncentiveCash Status : ',
        'incentiveCashCardInactiveActionRequired': 'This node has no IncentiveCash account connected to it. To set this up, please go to the IncentiveCash page.',
        'statusCardActionRequiredTitle': 'Action required:',
        'apkCardTitle': 'APK Version : ',
        'apkCardInactiveActionRequired': 'You are not running the latest version of the Minima app, you can find the latest version on our Get-Started page:<br><br><a href="https://minima.global/get-started">https://minima.global/get-started</a>',
        'apkCardStatusUpToDate': 'Up to date',
        'apkCardStatusOutOfDate': 'Out of date',
        'allDoneScreenCloseCTA': 'Close',
        'allDoneScreenTitle': 'Incentive Cash',
        'allDoneScreenBigTitle': 'All done!',
        'allDoneScreenContent': 'Your node is now connected to your IncentiveCash account and it will ping us so we know your node is connected to the network.\nFor every day we receive a ping from your node, we will add one IncentiveCash Token to your Balance.\nIncentiveCash Tokens will be redeemable for Minima coins at mainnet on a one for one basis.',
      }
    };
  }
}
