//
//  Constants.swift
//  ECE1778Project
//
//  Created by Yue Cai on 2020-01-26.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import Foundation

class Constants {
    
    // test
    struct Test {
        var name: String
        var instruction: String
        var questionCommon: String
        var question: [String]
        var answers: [String]
        var scores: [Int]
        var resultHeader: String
        var about: String
    }
    static let testList = [PCL5, PSQ, ISEL, DASS42D, DASS42A]
    
    // test PCL5 - PTSD
    static let PCL5Instruction = "A list of problems that people sometimes have in response to a very stressful experience. Please read each problem carefully and then choose one of the answers to indicate how much you have been bothered by that problem in the past month."
    static let PCL5QuestionCommon = "In the past month, how much were you bothered by: "
    static let PCL5Question =
        ["1. Repeated, disturbing, and unwanted memories of the stressful experience?",
         "2. Repeated, disturbing dreams of the stressful experience?",
         "3. Suddenly feeling or acting as if the stressful experience were actually happening again (as if you were actually back there reliving it)?",
         "4. Feeling very upset when something reminded you of the stressful experience?",
         "5. Having strong physical reactions when something reminded you of the stressful experience (for example, heart pounding, trouble breathing, sweating)?",
         "6. Avoiding memories, thoughts, or feelings related to the stressful experience?",
         "7. Avoiding external reminders of the stressful experience (for example, people, places, conversations, activities, objects, or situations)?",
         "8. Trouble remembering important parts of the stressful experience?",
         "9. Having strong negative beliefs about yourself, other people, or the world (for example, having thoughts such as: I am bad, there is something seriously wrong with me, no one can be trusted, the world is completely dangerous)?",
         "10. Blaming yourself or someone else for the stressful experience or what happened after it?",
         "11. Having strong negative feelings such as fear, horror, anger, guilt, or shame?",
         "12. Loss of interest in activities that you used to enjoy?",
         "13. Feeling distant or cut off from other people?",
         "14. Trouble experiencing positive feelings (for example, being unable to feel happiness or have loving feelings for people close to you)?",
         "15. Irritable behavior, angry outbursts, or acting aggressively?",
         "16. Taking too many risks or doing things that could cause you harm?",
         "17. Being “superalert” or watchful or on guard?",
         "18. Feeling jumpy or easily startled?",
         "19. Having difficulty concentrating?",
         "20. Trouble falling or staying asleep?"
        ]

    static let PCL5Answer = ["Not at All", "A little bit", "Moderately", "Quite a bit", "Extremely"]
    static let PCL5ResultHeader = "PTSD Symptom Score"
    static let PCL5About = "PTSD is a mental health condition that can develop after experiencing or witnessing a traumatic event. \r\n \r\n A significant change in PTSD score is a symptom score change of 5 or greater \r\n In civilian samples, about 8% of people will experience PTSD at some point of their lives. Approximately 28% of police officers qualify for clinical levels of PTSD (CAMH, 2018) \r\n \r\n Common symptoms include: \r\n - Re-experiencing: \r\n Re-experiencing symptoms may cause problems in a person’s everyday routine and include flashbacks, dreams, or re-living experiences. They can start from the person’s own thoughts and feelings. Words, objects, or situations that are reminders of the event can also trigger re-experiencing symptoms. \r\n \r\n - Avoidance: \r\n Things or situations that remind a person of the traumatic event can trigger avoidance symptoms. These symptoms may cause a person to change his or her personal routine. This may include avoiding triggers, thoughts, or feelings related to or reminding of the traumatic event. \r\n \r\n - Increased Arousal and reactivity: \r\n Arousal symptoms are usually constant rather than trigger-based, include, being easily startled, feeling tense or on edge, or increased physiological arousal (ex: increased heart rate, sweating, etc.).This may further lead to difficulty sleeping, and/or having angry outbursts \r\n \r\n - Cognition and mood: \r\n Negative mood, such as negative thoughts about oneself or the world, loss of interest in previously enjoyable activities, and feelings of guilt or blame. Cognitive symptoms can include memory issues, such as trouble remembering key features of the traumatic event."
    static let PCL5 = Test(name: "PCL5", instruction: PCL5Instruction, questionCommon: PCL5QuestionCommon, question: PCL5Question, answers: PCL5Answer, scores: [0, 1, 2, 3, 4], resultHeader: PCL5ResultHeader, about: PCL5About)
    
    // test PSQ
    static let PSQInstruction = "A list of items that describe different aspects of being a police officer. After each item, please circle how much stress it has caused you over the past 6 months, using a 7-point scale that ranges from “No Stress At All” to “A Lot Of Stress”"
    static let PSQQuestionCommon = "How much stress it has caused you over the past 6 months:"
    static let PSQQuestion =
        ["1. Shift work",
         "2. Working alone at night",
         "3. Over-time demands",
         "4. Risk of being injured on the job",
         "5. Work related activities on days off (e.g. court, community events)",
         "6. Traumatic events (e.g. MVA, domestics, death, injury)",
         "7. Managing your social life outside of work",
         "8. Not enough time available to spend with friends and family",
         "9. Paperwork",
         "10. Eating healthy at work",
         "11. Finding time to stay in good physical condition",
         "12. Fatigue (e.g. shift work, over-time)",
         "13. Occupation-related health issues (e.g. back pain)",
         "14. Lack of understanding from family and friends about your work",
         "15. Making friends outside the job",
         "16. Upholding a 'higher image' in public",
         "17. Negative comments from the public",
         "18. Limitations to your social life (e.g. who your friends are, where you socialize)",
         "19. Feeling like you are always on the job",
         "20. Friends / family feel the effects of the stigma associated with your job",
         "21. Dealing with co-workers",
         "22. The feeling that different rules apply to different people (e.g. favoritism)",
         "23. Feeling like you always have to prove yourself to the organization",
         "24. Excessive administrative duties",
         "25. Constant changes in policy / legislation",
         "26. Staff shortages",
         "27. Bureaucratic red tape",
         "28. Too much computer work",
         "29. Lack of training on new equipment",
         "30. Perceived pressure to volunteer free time",
         "31. Dealing with supervisors",
         "32. Inconsistent leadership style",
         "33. Lack of resources",
         "34. Unequal sharing of work responsibilities",
         "35. If you are sick or injured your co-workers seem to look down on you",
         "36. Leaders over-emphasize the negatives (e.g. supervisor evaluations, public complaints)",
         "37. Internal investigations",
         "38. Dealing with the court system",
         "39. The need to be accountable for doing your job",
         "40. Inadequate equipment"
        ]
    static let PSQAnswer = ["1(No Stress At All)", "2", "3", "4(Moderate Stress)", "5", "6", "7(A Lot Of Stress)"]
    static let PSQResultHeader = "Police Stress Symptom Score"
    static let PSQAbout = "There is a significant relationship between increased stress and decreased health outcomes. \r\n \r\n Individuals with higher stress exposure, including occupational stress, report significantly more adverse physical health symptoms (ex. Increased blood pressure, sleep problems), long-term health problems (ex. hypertension, coronary artery disease, auto-immune disorders, diabetes), and a higher risk for premature mortality. \r\n \r\n Mental health symptoms include depression, anxiety, PTSD, and other psychological ailments (ex. substance abuse). \r\n \r\n This can significantly impact work experiences, including reduced productivity and job satisfaction, increased absenteeism and burnout. It may also lead to increased use of health care resources. \r\n \r\n This questionnaire measures experiences with stressors specific to the policing occupation across 2 dimensions: \r\n \r\n - Operational Stress (i.e., field experiences) \r\n \r\n - Organizational Stress (i.e., office experiences)"
    static let PSQ = Test(name: "PSQ", instruction: PSQInstruction, questionCommon: PSQQuestionCommon, question: PSQQuestion, answers: PSQAnswer, scores: [1, 2, 3, 4, 5, 6, 7], resultHeader: PSQResultHeader, about: PSQAbout)
    
    // test ISEL
    static let ISELInstruction = "A list of statements each of which may or may not be true about you. For each statement check “definitely true” if you are sure it is true about you and “probably true” if you think it is true but are not absolutely certain. Similarly, you should check “definitely false” if you are sure the statement is false and “probably false” is you think it is false but are not absolutely certain."
    static let ISELQuestionCommon = "Check which is true about you:"
    static let ISELQuestion =
        ["1. There are several people that I trust to help solve my problems.",
         "2. If I needed help fixing an appliance or repairing my car, there is someone who would help me.",
         "3. Most of my friends are more interesting than I am.",
         "4. There is someone who takes pride in my accomplishments.",
         "5. When I feel lonely, there are several people I can talk to.",
         "6. There is no one that I feel comfortable to talking about intimate personal problems.",
         "7. I often meet or talk with family or friends.",
         "8. Most people I know think highly of me.",
         "9. If I needed a ride to the airport very early in the morning, I would have a hard time finding someone to take me.",
         "10. I feel like I’m not always included by my circle of friends.",
         "11. There really is no one who can give me an objective view of how I’m handling my problems.",
         "12. There are several different people I enjoy spending time with.",
         "13. I think that my friends feel that I’m not very good at helping them solve their problems.",
         "14. If I were sick and needed someone (friend, family member, or acquaintance) to take me to the doctor, I would have trouble finding someone.",
         "15. If I wanted to go on a trip for a day (e.g., to the mountains, beach, or country), I would have a hard time finding someone to go with me.",
         "16. If I needed a place to stay for a week because of an emergency (for example, water or electricity out in my apartment or house), I could easily find someone who would put me up.",
         "17. I feel that there is no one I can share my most private worries and fears with.",
         "18. If I were sick, I could easily find someone to help me with my daily chores.",
         "19. There is someone I can turn to for advice about handling problems with my family.",
         "20. I am as good at doing things as most other people are.",
         "21. If I decide one afternoon that I would like to go to a movie that evening, I could easily find someone to go with me.",
         "22. When I need suggestions on how to deal with a personal problem, I know someone I can turn to.",
         "23. If I needed an emergency loan of $100, there is someone (friend, relative, or acquaintance) I could get it from.",
         "24. In general, people do not have much confidence in me.",
         "25. Most people I know do not enjoy the same things that I do.",
         "26. There is someone I could turn to for advice about making career plans or changing my job.",
         "27. I don’t often get invited to do things with others.",
         "28. Most of my friends are more successful at making changes in their lives than I am.",
         "29. If I had to go out of town for a few weeks, it would be difficult to find someone who would look after my house or apartment (the plants, pets, garden, etc.).",
         "30. There really is no one I can trust to give me good financial advice.",
         "31. If I wanted to have lunch with someone, I could easily find someone to join me.",
         "32. I am more satisfied with my life than most people are with theirs.",
         "33. If I was stranded 10 miles from home, there is someone I could call who would come and get me.",
         "34. No one I know would throw a birthday party for me.",
         "35. It would me difficult to find someone who would lend me their car for a few hours.",
         "36. If a family crisis arose, it would be difficult to find someone who could give me good advice about how to handle it.",
         "37. I am closer to my friends than most other people are to theirs.",
         "38. There is at least one person I know whose advice I really trust.",
         "39. If I needed some help in moving to a new house or apartment, I would have a hard time finding someone to help me.",
         "40. I have a hard time keeping pace with my friends."
        ]
    static let ISELAnswer = ["definitely false", "probably false", "probably true", "definitely true"]
    static let ISELResultHeader = "Social Support Symptom Score"
    static let ISELAbout = "Social support can significantly positively impact mental as well as physical health. \r\n \r\n This questionnaire measures your perceived availability of potential social supports and resources across 4 categories: \r\n \r\n - tangible resources: availability material aid \r\n \r\n - appraisal resources: availability of someone to talk to about one’s problems \r\n \r\n - self-esteem: availability of a positive comparison when comparing one’s self to others \r\n \r\n - belonging: availability of people one can do things with"
    static let ISEL = Test(name: "ISEL", instruction: ISELInstruction, questionCommon: ISELQuestionCommon, question: ISELQuestion, answers: ISELAnswer, scores: [0, 1, 2, 3], resultHeader: ISELResultHeader, about: ISELAbout)
    
    // test DASS42Depression
    static let DASS42Instruction = "Please read each statement and choose a number 0, 1, 2, or 3 which indicates how much the statement applied to you over the past week. The rating scale is as follows: 0:Did not apply to me at all – NEVER, 1 Applied to me to some degree, or some of the time. - SOMETIMES, 2 Applied to me a considerable degree, or a good part of the time. - OFTEN, 3 Applied to me very much, or most of the time. - ALMOST ALWAYS "
    static let DASS42QuestionCommon = "Choose a number 0, 1, 2, or 3 which indicates how much the statement applied to you over the past week:"
    static let DASS42DQuestion =
        ["1. I couldn't seem to experience any positive feeling at all.",
         "2. I just couldn't seem to get going.",
         "3. I felt that I had nothing to look forward to.",
         "4. I felt sad and depressed.",
         "5. I felt that I had lost interest in just about everything.",
         "6. I felt I wasn't worth much as a person.",
         "7. I felt that life wasn't worthwhile.",
         "8. I couldn't seem to get any enjoyment out of the things I did.",
         "9. I felt down-hearted and blue.",
         "10. I was unable to become enthusiastic about anything.",
         "11. I felt I was pretty worthless.",
         "12. I could see nothing in the future to be hopeful about.",
         "13. I felt that life was meaningless.",
         "14. I found it difficult to work up the initiative to do things."
        ]
    static let DASS42Answer = ["NEVER", "SOMETIMES", "OFTEN", "ALMOST ALWAYS"]
    static let DASS42DResultHeader = "Depression Symptom Score"
    static let DASS42DAbout = "Depression is a mood disorder that can be described as feelings of sadness, loss, or anger. \r\n \r\n It can impact daily work, resulting in lost time and lower productivity, influence relationships, and can be associated with chronic health issues such as cardiovascular disease, diabetes, and obesity. \r\n \r\n It is a fairly common issue, with approximately 8% of adults experiencing depression. \r\n \r\n Symptoms may include: \r\n • Negative feelings (sad, empty, hopeless, anxious, irritable, angry) \r\n \r\n • Difficulty concentrating, completing tasks \r\n \r\n • Less interest in activities previously enjoyable \r\n \r\n • Insomnia, restless sleep \r\n \r\n • Decreased energy, fatigue, changes of appetite, digestive problems \r\n \r\n Individuals who score high on this questionnaire may experience the following characteristics: \r\n • self-disparaging \r\n \r\n • dispirited, gloomy, blue \r\n \r\n • convinced that life has no meaning or value \r\n \r\n • pessimistic about the future \r\n \r\n • unable to experience enjoyment or satisfaction \r\n \r\n • unable to become interested or involved \r\n \r\n • slow, lacking in initiative"
    static let DASS42D = Test(name: "DASS42", instruction: DASS42Instruction, questionCommon: DASS42QuestionCommon, question: DASS42DQuestion, answers: DASS42Answer, scores: [0, 1, 2, 3], resultHeader: DASS42DResultHeader, about: DASS42DAbout)
    
    // test DASS42Anxiety
    static let DASS42AQuestion =
        ["1. I was aware of dryness of my mouth.",
         "2. I experienced breathing difficulty (eg, excessively rapid breathing, breathlessness in the absence of physical exertion).",
         "3. I had a feeling of shakiness (eg, legs going to give way).",
         "4. I found myself in situations that made me so anxious I was most relieved when they ended.",
         "5. I had a feeling of faintness.",
         "6. I perspired noticeably (eg, hands sweaty) in the absence of high temperatures or physical exertion.",
         "7. I felt scared without any good reason.",
         "8. I had difficulty in swallowing.",
         "9. I was aware of the action of my heart in the absence of physical exertion (eg, sense of heart rate increase, heart missing a beat).",
         "10. I felt I was close to panic.",
         "11. I feared that I would be 'thrown' by some trivial but unfamiliar task.",
         "12. I felt terrified.",
         "13. I was worried about situations in which I might panic and make a fool of myself.",
         "14. I experienced trembling (eg, in the hands)."
        ]
    static let DASS42AResultHeader = "Anxiety Symptom Score"
    static let DASS42AAbout = "Anxiety is a natural physiological response to stress, an apprehension or fear of what can come. \r\n \r\n While a normal amount of anxiety comes and goes, chronic anxiety can be intense and debilitating, interfering with daily life and performance, Anxiety disorders are one of the most common forms of emotional disorders. \r\n \r\n Symptoms of anxiety may include: \r\n • increased heart rate \r\n \r\n • rapid breathing \r\n \r\n • restlessness \r\n \r\n • trouble concentrating \r\n \r\n • difficulty falling asleep \r\n \r\n Individuals scoring higher on this questionnaire may experience the following characteristics: \r\n • apprehensive, panicky \r\n \r\n • trembly, shaky \r\n \r\n • aware of dryness of the mouth, breathing difficulties, pounding of the heart, sweatiness of the palms \r\n \r\n • worried about performance and possible loss of control"
    static let DASS42A = Test(name: "DASS42", instruction: DASS42Instruction, questionCommon: DASS42QuestionCommon, question: DASS42AQuestion, answers: DASS42Answer, scores: [0, 1, 2, 3], resultHeader: DASS42AResultHeader, about: DASS42AAbout)
    
    // analysis
    static let restingDescription = "Resting Heart Rate \r\n A normal resting heart rate for adults ranges from 60 to 100 beats per minute. Generally, a lower heart rate at rest implies more efficient heart function and better cardiovascular fitness. For example, a well-trained athlete might have a normal resting heart rate closer to 40 beats per minute."
    
    static let heartHomeList = ["     Critical Incident Log          >>", "     Resting HR                                   >>", "     Avg. Max HR:  "]
}
