/*
    This example apex class extends Slack.SlashCommandDispatcher and is responsible for 
    responding to the Slack slash command registered with the Slack application.

    This command will open a modal to view record details for Accounts, Contacts, and Opportunities
    
    sample command:
    /apex-view-record Contact 003xx000004WhrYAAS
    /apex-view-record Account 00Bxx0000029bnsEAA
    /apex-view-record Opportunity 006xx000001a3f5AAA

    If you run the command in a slack channel, you will see the option to post a message with record details there.
*/
public class ViewRecordCommandDispatcher extends Slack.SlashCommandDispatcher {
    public override Slack.ActionHandler invoke(Slack.SlashCommandParameters parameters, Slack.RequestContext context) {
        return Slack.ActionHandler.ack(new Handler(parameters, context));
    }

    public class Handler implements Slack.RunnableHandler {
        Slack.SlashCommandParameters parameters;
        Slack.RequestContext context;

        public Handler(Slack.SlashCommandParameters parameters, Slack.RequestContext context) {
            this.parameters = parameters;
            this.context = context;
        }

        public void run() {
            //name must match the DeveloperName of your SlackApp.
            Slack.App app = Slack.App.HelloSlackApp.get();
            Slack.UserClient userClient = app.getUserClientForTeam(context.getTeamId(), context.getUserId());

            /*Slack.ConversationsInfoRequest conversationsInfoReq = new Slack.ConversationsInfoRequest.builder()
                .channel(context.getchannelId())
                .build();
            Slack.ConversationsInfoResponse conversationsInfoResponse = userClient.ConversationsInfo(
                conversationsInfoReq
            );
            if (conversationsInfoResponse.getError() != null) {
                System.debug(conversationsInfoResponse.getError());
            }
            System.debug(conversationsInfoResponse);*/

            /*Slack.UsersInfoRequest userReq = new Slack.UsersInfoRequest.builder()
                .user(conversationsInfoResponse.get('channel').get('user'))
                .build();
            Slack.UsersInfoResponse userResponse = userClient.UsersInfo(userReq);*/

            String contactName = (String) parameters.getText();
            Slack.ViewReference viewReference = Slack.View.record_detail_message.get();
            viewReference.setParameter('contactName', contactName);

            Slack.ChatPostEphemeralRequest req = new Slack.ChatPostEphemeralRequest.builder()
                .channel(context.getchannelId())
                //TODO should text be required if you are setting a view reference?
                .viewReference(viewReference)
                .user(context.getUserId())
                .build();

            Slack.ChatPostEphemeralResponse response = userClient.ChatPostEphemeral(req);
            if (response.getError() != null) {
                System.debug(response.getError());
            }
        }
    }
}
