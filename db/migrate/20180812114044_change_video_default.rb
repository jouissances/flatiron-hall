class ChangeVideoDefault < ActiveRecord::Migration
    def change
        change_column_default :projects, :video_url, "https://previews.dropbox.com/p/orig/AALLu4qexe4eU7T5bGxzyH9_PR8rB915D7agQUw_uIzME3onBZDmO12fowl6_McLBUqDARxX3KSMvEATbxJee989K67r4KKGASU1-9165ihl1tIUQXq59G-3vHdEKiTI2J2WfY2Vu9hP3GYc_Iew4HQx7aaOYTLugxx-m9Xj6ENJmNCmYfcOIdKId_kGbeGysGcCYA_WpGkP-fCT_ClrTCkt/p.gif?size=1024x768&size_mode=3"
    end

end