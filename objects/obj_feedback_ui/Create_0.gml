pos_x = GUI_W * 0.20;
pos_y = GUI_H * 0.60;

global.ui_feedback = new FeedbackManager(spr_selector_locked, 4, 50, 60);

global.ui_feedback.show_feedback("TARGET OUT OF RANGE", FeedbackType.alert, 4);
global.ui_feedback.show_feedback("TARGET OUT OF RANGE", FeedbackType.neutral, 3);
global.ui_feedback.show_feedback("TARGET OUT OF RANGE", FeedbackType.positive, 5);
global.ui_feedback.show_feedback("TARGET OUT OF RANGE", FeedbackType.alarm, 6);