class WelcomeController<ApplicationController

def index
  if current_user && @activities != []
  @activities = PublicActivity::Activity.order("created_at desc")
   .where(owner_type: "User",
          owner_id: current_user.following.map {|u| u.id})
   .limit(20)
 end
end



private

def load_activities
  @activities = PublicActivity::Activity.order('created_at DESC').limit(20)
end


end
