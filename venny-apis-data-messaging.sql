-- public.threads definition

-- Drop table

-- DROP TABLE public.threads;

CREATE TABLE public.threads (
	id int4 NOT NULL DEFAULT nextval('threads_sequence'::regclass),
	thread_id varchar(30) NOT NULL,
	thread_attributes json NULL,
	thread_title varchar(255) NULL,
	thread_participants jsonb NOT NULL,
	thread_preview varchar(255) NULL,
	profile_id varchar(30) NOT NULL,
	app_id varchar(30) NOT NULL,
	event_id varchar(30) NOT NULL,
	process_id varchar(30) NOT NULL,
	time_started timestamptz NOT NULL DEFAULT now(),
	time_updated timestamptz NOT NULL DEFAULT now(),
	time_finished timestamptz NOT NULL DEFAULT now(),
	active int4 NOT NULL DEFAULT 1,
	CONSTRAINT threads_thread_id_key UNIQUE (thread_id)
);
CREATE INDEX idx_contributors ON public.threads USING btree (((thread_participants -> 'contributors'::text)));

-- Permissions

ALTER TABLE public.threads OWNER TO iyniiwcwqpvrci;
GRANT ALL ON TABLE public.threads TO iyniiwcwqpvrci;


-- public.messages definition

-- Drop table

-- DROP TABLE public.messages;

CREATE TABLE public.messages (
	id int4 NOT NULL DEFAULT nextval('messages_sequence'::regclass),
	message_id varchar(30) NOT NULL,
	message_attributes json NULL,
	message_body text NOT NULL,
	message_images jsonb NULL,
	message_deleted int4 NULL DEFAULT 0,
	thread_id varchar(30) NOT NULL,
	profile_id varchar(30) NOT NULL,
	app_id varchar(30) NOT NULL,
	event_id varchar(30) NOT NULL,
	process_id varchar(30) NOT NULL,
	time_started timestamptz NOT NULL DEFAULT now(),
	time_updated timestamptz NOT NULL DEFAULT now(),
	time_finished timestamptz NOT NULL DEFAULT now(),
	active int4 NOT NULL DEFAULT 1,
	CONSTRAINT messages_message_id_key UNIQUE (message_id),
	CONSTRAINT messages_thread_id_fkey FOREIGN KEY (thread_id) REFERENCES threads(thread_id)
);

-- Permissions

ALTER TABLE public.messages OWNER TO iyniiwcwqpvrci;
GRANT ALL ON TABLE public.messages TO iyniiwcwqpvrci;

INSERT INTO public.messages (message_id,message_attributes,message_body,message_images,message_deleted,thread_id,profile_id,app_id,event_id,process_id,time_started,time_updated,time_finished,active) VALUES
	 ('30 characters','{}','lorem ipsum','{}',1,'30 characters','30 characters','30 characters','30 characters','30 characters','2020-06-20 18:46:12.664021-05','2020-06-20 18:46:12.664021-05','2020-06-20 18:46:12.664021-05',1),
	 ('msg_b45ec9c2ba4c6',NULL,'This is that boi Al','{}',0,'thr_067b4cc8cbfdf','prf_8072738b47905','app_thentrlco','obj_374b0ba8759c0','obj_3bf1982fa4887','2020-06-20 18:46:56.988916-05','2020-06-20 18:46:56.988916-05','2020-06-20 18:46:56.988916-05',1),
	 ('msg_ecbde88b4380c',NULL,'Man, this Mr. Speaker been looking forward to chatting with you.','{}',0,'thr_067b4cc8cbfdf','prf_71a6327f41860','app_thentrlco','obj_fc8a86e46a6e7','obj_af73b4fe39e1f','2020-06-20 18:47:02.761479-05','2020-06-20 18:47:02.761479-05','2020-06-20 18:47:02.761479-05',1),
	 ('msg_eaf83207c288d',NULL,'How long are you in town? I need your help with some music.','{}',0,'thr_067b4cc8cbfdf','prf_71a6327f41860','app_thentrlco','obj_cc77e746fc1c0','obj_eb08d0df382b0','2020-06-20 18:47:09.645407-05','2020-06-20 18:47:09.645407-05','2020-06-20 18:47:09.645407-05',1),
	 ('msg_92c2812c975db',NULL,'If you''re working on something big I . . can . . be here until July... What''s up?','{}',0,'thr_067b4cc8cbfdf','prf_8072738b47905','app_thentrlco','obj_b46df27fd8325','obj_f94b44cc7d91e','2020-06-20 18:47:19.292804-05','2020-06-20 18:47:19.292804-05','2020-06-20 18:47:19.292804-05',1),
	 ('msg_6029b5e87adbe',NULL,'Well sheeeeeit I''mma get this EP done then.','{}',0,'thr_067b4cc8cbfdf','prf_71a6327f41860','app_thentrlco','obj_4fb6355880758','obj_ac5450b61273e','2020-06-20 18:56:20.934903-05','2020-06-20 18:56:20.934903-05','2020-06-20 18:56:20.934903-05',1),
	 ('msg_c8f16e3848705',NULL,'2 more tracks left.','{}',0,'thr_067b4cc8cbfdf','prf_71a6327f41860','app_thentrlco','obj_2e9ff4f38e543','obj_3cd735ddbe2e0','2020-06-20 18:56:32.912126-05','2020-06-20 18:56:32.912126-05','2020-06-20 18:56:32.912126-05',1),
	 ('msg_81843192adb9a',NULL,'Bet. I got you on the 808s and motifs then.','{}',0,'thr_067b4cc8cbfdf','prf_8072738b47905','app_thentrlco','obj_a0b4c2c7d318c','obj_1265082668824','2020-06-20 18:57:05.430057-05','2020-06-20 18:57:05.430057-05','2020-06-20 18:57:05.430057-05',1),
	 ('msg_51f5827b30af3',NULL,'Much appreciated.','{}',0,'thr_067b4cc8cbfdf','prf_71a6327f41860','app_thentrlco','obj_13e7888acdd64','obj_ebc2124910e2b','2020-06-20 18:57:58.407161-05','2020-06-20 18:57:58.407161-05','2020-06-20 18:57:58.407161-05',1),
	 ('msg_73a249d8a8569',NULL,'That''s a win nowadays.','{}',0,'thr_067b4cc8cbfdf','prf_8072738b47905','app_thentrlco','obj_1674f624828d4','obj_2b5dd526349e6','2020-06-20 18:57:20.860243-05','2020-06-20 18:57:20.860243-05','2020-06-20 18:57:20.860243-05',1);
INSERT INTO public.messages (message_id,message_attributes,message_body,message_images,message_deleted,thread_id,profile_id,app_id,event_id,process_id,time_started,time_updated,time_finished,active) VALUES
	 ('msg_7897d3447867a',NULL,'Dude, you''re going to save this project.','{}',0,'thr_067b4cc8cbfdf','prf_71a6327f41860','app_thentrlco','obj_a052f1056f4b0','obj_91f545109c35b','2020-06-20 18:57:49.21765-05','2020-06-20 18:57:49.21765-05','2020-06-20 18:57:49.21765-05',1),
	 ('msg_e9b69d83812e6',NULL,'Good that I caught you on the way out.','{}',0,'thr_fdf747b1ba25e','prf_8072738b47905','app_thentrlco','obj_df6f42905047f','obj_cab08f122578f','2020-06-20 18:59:45.812725-05','2020-06-20 18:59:45.812725-05','2020-06-20 18:59:45.812725-05',1),
	 ('msg_4a64f460139bf',NULL,'The answer is yes. I am helping Speak.','{}',0,'thr_fdf747b1ba25e','prf_8072738b47905','app_thentrlco','obj_424d2c7e4cef3','obj_e39a25c99fcbb','2020-06-20 19:00:08.01376-05','2020-06-20 19:00:08.01376-05','2020-06-20 19:00:08.01376-05',1),
	 ('msg_450dae7cb3b88',NULL,'👀','{}',0,'thr_fdf747b1ba25e','prf_6bab84ca976f0','app_thentrlco','obj_d38a51e3f5a76','obj_4c1f401e4c14d','2020-06-20 19:01:08.246333-05','2020-06-20 19:01:08.246333-05','2020-06-20 19:01:08.246333-05',1),
	 ('msg_d8c06cce9e7c8',NULL,'Y''all ''bout to kill.','{}',0,'thr_fdf747b1ba25e','prf_6bab84ca976f0','app_thentrlco','obj_74bfc045f975f','obj_4121122856a41','2020-06-20 19:01:36.378981-05','2020-06-20 19:01:36.378981-05','2020-06-20 19:01:36.378981-05',1),
	 ('msg_c8ddf03686297',NULL,'Much appreciated.','{}',0,'thr_fdf747b1ba25e','prf_8072738b47905','app_thentrlco','obj_07ec5c29185b1','obj_d983f7d27b383','2020-06-20 19:03:26.454173-05','2020-06-20 19:03:26.454173-05','2020-06-20 19:03:26.454173-05',1),
	 ('msg_4f4a7c9c4e902',NULL,'Bless up.','{}',0,'thr_fdf747b1ba25e','prf_8072738b47905','app_thentrlco','obj_64afb37583379','obj_269892b32c294','2020-06-20 19:03:32.697661-05','2020-06-20 19:03:32.697661-05','2020-06-20 19:03:32.697661-05',1),
	 ('msg_0f938f9866a3a',NULL,'You know damn well you finna be on this hook, right...?','{}',0,'thr_d86ccf10688f9','prf_8072738b47905','app_thentrlco','obj_dbd247db260a8','obj_9eb67301e2b1e','2020-06-20 19:15:50.283279-05','2020-06-20 19:15:50.283279-05','2020-06-20 19:15:50.283279-05',1),
	 ('msg_6a323c3eb4390',NULL,'Boy, I''m already on my doubles. Bloop.','{}',0,'thr_d86ccf10688f9','prf_ca350aa93607a','app_thentrlco','obj_c70bef8a58247','obj_75130f1bbed74','2020-06-20 19:16:38.393644-05','2020-06-20 19:16:38.393644-05','2020-06-20 19:16:38.393644-05',1),
	 ('msg_315ae8c7b2dd9',NULL,'Been here since noon.','{}',0,'thr_d86ccf10688f9','prf_ca350aa93607a','app_thentrlco','obj_4c0acdfd0dd2b','obj_27a97b72908a3','2020-06-20 19:16:48.21536-05','2020-06-20 19:16:48.21536-05','2020-06-20 19:16:48.21536-05',1);
INSERT INTO public.messages (message_id,message_attributes,message_body,message_images,message_deleted,thread_id,profile_id,app_id,event_id,process_id,time_started,time_updated,time_finished,active) VALUES
	 ('msg_cbf20117338ee',NULL,'Elk...!!! Girl, it''s almost 4...!!!','{}',0,'thr_d86ccf10688f9','prf_8072738b47905','app_thentrlco','obj_e01e954cb38dd','obj_d8ad5f85f7173','2020-06-20 19:17:13.110118-05','2020-06-20 19:17:13.110118-05','2020-06-20 19:17:13.110118-05',1),
	 ('msg_89b58bcf5fc1b',NULL,'Oh, you workin'' workin''','{}',0,'thr_d86ccf10688f9','prf_8072738b47905','app_thentrlco','obj_2c09d35043fce','obj_ff8549f7be9cb','2020-06-20 19:17:28.62936-05','2020-06-20 19:17:28.62936-05','2020-06-20 19:17:28.62936-05',1),
	 ('msg_6ebcd462ae0b5',NULL,'👅','{}',0,'thr_d86ccf10688f9','prf_ca350aa93607a','app_thentrlco','obj_d0268724dd1f6','obj_dd72247e4ef51','2020-06-20 19:18:04.911377-05','2020-06-20 19:18:04.911377-05','2020-06-20 19:18:04.911377-05',1),
	 ('msg_b0b97c5b591f7',NULL,'Don''t play with me.','{}',0,'thr_d86ccf10688f9','prf_8072738b47905','app_thentrlco','obj_f655298078125','obj_2d50f0c194838','2020-06-20 19:18:22.636868-05','2020-06-20 19:18:22.636868-05','2020-06-20 19:18:22.636868-05',1),
	 ('msg_e10446f4d3a42',NULL,'Are you in town?','{}',0,'thr_be10f23a2ffb6','prf_8072738b47905','app_thentrlco','obj_e1116c289a4b9','obj_e7acf447f4b59','2020-06-20 19:20:53.572072-05','2020-06-20 19:20:53.572072-05','2020-06-20 19:20:53.572072-05',1),
	 ('msg_ff06b56a30609',NULL,'Not yet, but on a red-eye @ midnight. See y''all in the morning.','{}',0,'thr_be10f23a2ffb6','prf_a6b3c606b1ccb','app_thentrlco','obj_0b8c1c98bfa0c','obj_df1ec79729f95','2020-06-20 19:21:46.160024-05','2020-06-20 19:21:46.160024-05','2020-06-20 19:21:46.160024-05',1),
	 ('msg_22aa7a89e372d',NULL,'🛬','{}',0,'thr_be10f23a2ffb6','prf_a6b3c606b1ccb','app_thentrlco','obj_5970ca7065b39','obj_8a4feea2d1ff0','2020-06-20 19:22:15.539433-05','2020-06-20 19:22:15.539433-05','2020-06-20 19:22:15.539433-05',1),
	 ('msg_d2ca3c3ef24b3',NULL,'🛬🚀🏆','{}',0,'thr_be10f23a2ffb6','prf_8072738b47905','app_thentrlco','obj_2e2449428bddf','obj_128f772249d8d','2020-06-20 19:22:52.564641-05','2020-06-20 19:22:52.564641-05','2020-06-20 19:22:52.564641-05',1),
	 ('msg_6c1a24786d140',NULL,'Elsa, I can''t believe I''m goign to be on this project...!!!','{}',0,'thr_ed13f9cd3246d','prf_ca350aa93607a','app_thentrlco','obj_949a07bd79d57','obj_e358fc977fde4','2020-06-20 19:36:26.793818-05','2020-06-20 19:36:26.793818-05','2020-06-20 19:36:26.793818-05',1),
	 ('msg_143d6fd864936',NULL,'Girl, I got on the first plane back to New York. I''ll be having lunch with y''all in BedStuy TOMORROW.','{}',0,'thr_ed13f9cd3246d','prf_a6b3c606b1ccb','app_thentrlco','obj_de0682316b95e','obj_0eaa5abde23fb','2020-06-20 19:39:07.203389-05','2020-06-20 19:39:07.203389-05','2020-06-20 19:39:07.203389-05',1);
INSERT INTO public.messages (message_id,message_attributes,message_body,message_images,message_deleted,thread_id,profile_id,app_id,event_id,process_id,time_started,time_updated,time_finished,active) VALUES
	 ('msg_f42ee238d14a0',NULL,'Lord, this is happening. We needed this. God is good.','{}',0,'thr_ed13f9cd3246d','prf_ca350aa93607a','app_thentrlco','obj_6755b55d322bf','obj_cff16de59ed85','2020-06-20 19:39:26.830932-05','2020-06-20 19:39:26.830932-05','2020-06-20 19:39:26.830932-05',1),
	 ('msg_2b845a9a9d301',NULL,'We deserve this shot.','{}',0,'thr_ed13f9cd3246d','prf_ca350aa93607a','app_thentrlco','obj_91fbc9ad5a543','obj_cfb79d2fc7a0b','2020-06-20 19:40:40.592929-05','2020-06-20 19:40:40.592929-05','2020-06-20 19:40:40.592929-05',1),
	 ('msg_94b2a9175ead9',NULL,'We can sing. We got the look. We ain''t afraid of work. It''s time.','{}',0,'thr_ed13f9cd3246d','prf_ca350aa93607a','app_thentrlco','obj_11beacfdb1864','obj_c0db00225bb60','2020-06-20 19:41:03.276377-05','2020-06-20 19:41:03.276377-05','2020-06-20 19:41:03.276377-05',1),
	 ('msg_44d124c19b29d',NULL,'Are you serious right now...?!?! TOMORROW IS GOING TO SLAY!!! It''s our time.','{}',0,'thr_ed13f9cd3246d','prf_a6b3c606b1ccb','app_thentrlco','obj_4bca79db63c05','obj_31c32bdb3e263','2020-06-20 19:41:30.844872-05','2020-06-20 19:41:30.844872-05','2020-06-20 19:41:30.844872-05',1),
	 ('msg_4ec915ec92d60',NULL,'What should I wear?','{}',0,'thr_ed13f9cd3246d','prf_a6b3c606b1ccb','app_thentrlco','obj_76619278dfe02','obj_912ab859b69bd','2020-06-20 19:42:04.054593-05','2020-06-20 19:42:04.054593-05','2020-06-20 19:42:04.054593-05',1),
	 ('msg_8a7f145ea87be',NULL,'try it now.',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_e38d7ce406773','obj_f83d1125d992a','2020-10-31 08:12:30.707335-05','2020-10-31 08:12:30.707335-05','2020-10-31 08:12:30.707335-05',1),
	 ('msg_fe9b9f7f9840e',NULL,'It don''t matter what you walk in this studio with. Hell, you''ll be out of it super quick. It''s hot AF in here as usual.','{}',0,'thr_ed13f9cd3246d','prf_ca350aa93607a','app_thentrlco','obj_ecc056a85f2bb','obj_23c10bf6a179a','2020-06-20 19:42:45.768204-05','2020-06-20 19:42:45.768204-05','2020-06-20 19:42:45.768204-05',1),
	 ('msg_781f9ee08d1f9',NULL,'You know Al be having it hot to keep people off they game.','{}',0,'thr_ed13f9cd3246d','prf_ca350aa93607a','app_thentrlco','obj_155877962f431','obj_28f5e00840fea','2020-06-20 19:43:07.485339-05','2020-06-20 19:43:07.485339-05','2020-06-20 19:43:07.485339-05',1),
	 ('msg_252b17ad46978',NULL,'Girl, that nigga think he smart and shit... I meeeean he is but... he ain''t smart smart... actually','{}',0,'thr_ed13f9cd3246d','prf_a6b3c606b1ccb','app_thentrlco','obj_eb5939584c09e','obj_7711a7b79178d','2020-06-20 19:43:42.544239-05','2020-06-20 19:43:42.544239-05','2020-06-20 19:43:42.544239-05',1),
	 ('msg_22ff46935d642',NULL,'...actually...','{}',0,'thr_ed13f9cd3246d','prf_a6b3c606b1ccb','app_thentrlco','obj_3cb59d158b106','obj_1707837c24378','2020-06-20 19:43:50.491505-05','2020-06-20 19:43:50.491505-05','2020-06-20 19:43:50.491505-05',1);
INSERT INTO public.messages (message_id,message_attributes,message_body,message_images,message_deleted,thread_id,profile_id,app_id,event_id,process_id,time_started,time_updated,time_finished,active) VALUES
	 ('msg_9979a23cec4b1',NULL,'🤔','{}',0,'thr_ed13f9cd3246d','prf_a6b3c606b1ccb','app_thentrlco','obj_3c412aa211181','obj_9ce599a93d3a4','2020-06-20 19:44:21.228434-05','2020-06-20 19:44:21.228434-05','2020-06-20 19:44:21.228434-05',1),
	 ('msg_290730ace2c62',NULL,'he kind of is','{}',0,'thr_ed13f9cd3246d','prf_a6b3c606b1ccb','app_thentrlco','obj_1847baeeeef34','obj_8b1625d7b5c68','2020-06-20 19:44:25.757085-05','2020-06-20 19:44:25.757085-05','2020-06-20 19:44:25.757085-05',1),
	 ('msg_af550cd1be18c',NULL,'🤷🏾‍♀️','{}',0,'thr_ed13f9cd3246d','prf_a6b3c606b1ccb','app_thentrlco','obj_3b1be4b9e83d8','obj_90dd894d15a25','2020-06-20 19:45:05.27299-05','2020-06-20 19:45:05.27299-05','2020-06-20 19:45:05.27299-05',1),
	 ('msg_484bce02665f6',NULL,'What happens next?',NULL,0,'thr_fdf747b1ba25e','prf_8072738b47905','app_thentrlco','obj_1b589fdfc787c','obj_f79b0f578225f','2020-06-21 08:34:21.024401-05','2020-06-21 08:34:21.024401-05','2020-06-21 08:34:21.024401-05',1),
	 ('msg_ff0974066d410',NULL,'Liv is on the couch',NULL,0,'thr_be10f23a2ffb6','prf_8072738b47905','app_thentrlco','obj_e7c425f225b4f','obj_48e2b0cdee80d','2020-06-21 21:34:37.898482-05','2020-06-21 21:34:37.898482-05','2020-06-21 21:34:37.898482-05',1),
	 ('msg_907d8bd67d24c',NULL,'I can’t believe this. Watching billions.',NULL,0,'thr_5a017dd89c36a','prf_8072738b47905','app_thentrlco','obj_c1e94ae34a6f8','obj_e2bca89fefc3b','2020-06-22 23:06:05.427722-05','2020-06-22 23:06:05.427722-05','2020-06-22 23:06:05.427722-05',1),
	 ('msg_2445eafe51a4f',NULL,'But if no one fires, then everyone survives.',NULL,0,'thr_5a017dd89c36a','prf_8072738b47905','app_thentrlco','obj_20e7d46ed47bc','obj_b6f8a90053066','2020-06-22 23:08:08.052084-05','2020-06-22 23:08:08.052084-05','2020-06-22 23:08:08.052084-05',1),
	 ('msg_f5522660f2da6',NULL,'go ninja go',NULL,0,'thr_5a017dd89c36a','prf_8072738b47905','app_thentrlco','obj_3246244535218','obj_172d77add3016','2020-06-22 23:09:52.054664-05','2020-06-22 23:09:52.054664-05','2020-06-22 23:09:52.054664-05',1),
	 ('msg_8c92116ca447e',NULL,'We can run a friction test up there.',NULL,0,'thr_5a017dd89c36a','prf_8072738b47905','app_thentrlco','obj_2201ee6f4cdca','obj_12240fc11f642','2020-06-22 23:12:47.194503-05','2020-06-22 23:12:47.194503-05','2020-06-22 23:12:47.194503-05',1),
	 ('msg_1c61211ad875e',NULL,'Boom. Kaboom.',NULL,0,'thr_5a017dd89c36a','prf_8072738b47905','app_thentrlco','obj_d9c5df3b00859','obj_212d699b6f992','2020-06-22 23:14:40.541741-05','2020-06-22 23:14:40.541741-05','2020-06-22 23:14:40.541741-05',1);
INSERT INTO public.messages (message_id,message_attributes,message_body,message_images,message_deleted,thread_id,profile_id,app_id,event_id,process_id,time_started,time_updated,time_finished,active) VALUES
	 ('msg_7ef4763664175',NULL,'I can be scared... but not scared away.',NULL,0,'thr_5a017dd89c36a','prf_8072738b47905','app_thentrlco','obj_ff3fec31e03a7','obj_6b1a95d42836c','2020-06-23 00:04:14.720517-05','2020-06-23 00:04:14.720517-05','2020-06-23 00:04:14.720517-05',1),
	 ('msg_27e4673744882',NULL,'',NULL,0,'thr_d86ccf10688f9','prf_8072738b47905','app_thentrlco','obj_7ed58c27e468d','obj_831ee45b1bca2','2020-06-23 00:07:28.708541-05','2020-06-23 00:07:28.708541-05','2020-06-23 00:07:28.708541-05',1),
	 ('msg_7523de746922a',NULL,'On some next leve shit.',NULL,0,'thr_d86ccf10688f9','prf_8072738b47905','app_thentrlco','obj_08526e9f9591e','obj_14a50e00bf31e','2020-06-23 00:07:37.140174-05','2020-06-23 00:07:37.140174-05','2020-06-23 00:07:37.140174-05',1),
	 ('msg_9cecbb13493c8',NULL,'This is bd4',NULL,0,'thr_c21056ffe3f0d','prf_8072738b47905','app_thentrlco','obj_0570de4eabe22','obj_2815beeabeb32','2020-06-23 00:08:22.874351-05','2020-06-23 00:08:22.874351-05','2020-06-23 00:08:22.874351-05',1),
	 ('msg_581543a872049',NULL,'This GOT DAMn 522',NULL,0,'thr_74dfdb69d47f9','prf_8072738b47905','app_thentrlco','obj_63c139a73763d','obj_2c3ff0f289d6c','2020-06-23 00:08:45.526881-05','2020-06-23 00:08:45.526881-05','2020-06-23 00:08:45.526881-05',1),
	 ('msg_be4972421ba49',NULL,'This is CBC... man this might b working',NULL,0,'thr_9209931912afc','prf_8072738b47905','app_thentrlco','obj_1ad4d2f4b2884','obj_d91143fa1e460','2020-06-23 00:09:10.869905-05','2020-06-23 00:09:10.869905-05','2020-06-23 00:09:10.869905-05',1),
	 ('msg_4188cd00a9a1a',NULL,'44a in the house',NULL,0,'thr_2b430b2d4dfad','prf_8072738b47905','app_thentrlco','obj_6990c09ea4c0c','obj_d849282745955','2020-06-23 00:09:51.918347-05','2020-06-23 00:09:51.918347-05','2020-06-23 00:09:51.918347-05',1),
	 ('msg_5497b1f11e861',NULL,'man are works like a MF',NULL,0,'thr_1276f9be89303','prf_8072738b47905','app_thentrlco','obj_8c976b5448b08','obj_77858719c5226','2020-06-23 00:10:22.659884-05','2020-06-23 00:10:22.659884-05','2020-06-23 00:10:22.659884-05',1),
	 ('msg_92ad90aa5398f',NULL,'',NULL,0,'thr_1e7e7b5fcb9ee','prf_8072738b47905','app_thentrlco','obj_eed5b2c09a9bc','obj_28fa48d4240ea','2020-06-23 00:10:38.989113-05','2020-06-23 00:10:38.989113-05','2020-06-23 00:10:38.989113-05',1),
	 ('msg_d7876df85e3f8',NULL,'this an the one before is bb44',NULL,0,'thr_1e7e7b5fcb9ee','prf_8072738b47905','app_thentrlco','obj_df64f1add26c2','obj_7d004fba65387','2020-06-23 00:10:56.429594-05','2020-06-23 00:10:56.429594-05','2020-06-23 00:10:56.429594-05',1);
INSERT INTO public.messages (message_id,message_attributes,message_body,message_images,message_deleted,thread_id,profile_id,app_id,event_id,process_id,time_started,time_updated,time_finished,active) VALUES
	 ('msg_a3fec514ab015',NULL,'4936',NULL,0,'thr_aa054bd0664d7','prf_8072738b47905','app_thentrlco','obj_8c62def46c86a','obj_e1e373f1d289b','2020-06-23 00:11:15.162996-05','2020-06-23 00:11:15.162996-05','2020-06-23 00:11:15.162996-05',1),
	 ('msg_a552a4a1c213a',NULL,'this is 8cc yeah he did',NULL,0,'thr_b73f7ac46356d','prf_8072738b47905','app_thentrlco','obj_fffd3d9e2486a','obj_d22ed594d97ef','2020-06-23 00:11:39.77998-05','2020-06-23 00:11:39.77998-05','2020-06-23 00:11:39.77998-05',1),
	 ('msg_2c42c74e591f9',NULL,'70 and most people don’t care',NULL,0,'thr_62999367fe651','prf_8072738b47905','app_thentrlco','obj_b852ff145ac89','obj_173888f31798e','2020-06-23 00:12:09.276569-05','2020-06-23 00:12:09.276569-05','2020-06-23 00:12:09.276569-05',1),
	 ('msg_7aa23503f32e8',NULL,'looks like this is me',NULL,0,'thr_5a017dd89c36a','prf_8072738b47905','app_thentrlco','obj_27728619c8b1b','obj_297e8051c427a','2020-06-23 00:12:23.96987-05','2020-06-23 00:12:23.96987-05','2020-06-23 00:12:23.96987-05',1),
	 ('msg_151ac3bea62e7',NULL,'6f0 really works... WOW',NULL,0,'thr_fdf747b1ba25e','prf_8072738b47905','app_thentrlco','obj_f9e96afa1ae1b','obj_be05c8d52f2c8','2020-06-23 00:12:41.96556-05','2020-06-23 00:12:41.96556-05','2020-06-23 00:12:41.96556-05',1),
	 ('msg_e0371401a0426',NULL,'670 what did you do to fix it',NULL,0,'thr_d86ccf10688f9','prf_8072738b47905','app_thentrlco','obj_6b0f97b6b3fcf','obj_0ae8aa5848374','2020-06-23 00:13:00.210645-05','2020-06-23 00:13:00.210645-05','2020-06-23 00:13:00.210645-05',1),
	 ('msg_54bd30abfad90',NULL,'07a fuck our actions... we still must forge on',NULL,0,'thr_d86ccf10688f9','prf_8072738b47905','app_thentrlco','obj_f823ed8013aa6','obj_276180f96ef71','2020-06-23 00:13:34.018464-05','2020-06-23 00:13:34.018464-05','2020-06-23 00:13:34.018464-05',1),
	 ('msg_23d67c556c18b',NULL,'',NULL,0,'thr_be10f23a2ffb6','prf_8072738b47905','app_thentrlco','obj_bcafb167510b8','obj_29c52b100f4be','2020-06-23 00:13:42.210458-05','2020-06-23 00:13:42.210458-05','2020-06-23 00:13:42.210458-05',1),
	 ('msg_ab42183aeaf28',NULL,'CCB in this mug...',NULL,0,'thr_be10f23a2ffb6','prf_8072738b47905','app_thentrlco','obj_81646fbd84f18','obj_68c91a0eb64eb','2020-06-23 00:13:51.8161-05','2020-06-23 00:13:51.8161-05','2020-06-23 00:13:51.8161-05',1),
	 ('msg_925fbf0fb60ca',NULL,'860 there are other names on the hit list.',NULL,0,'thr_067b4cc8cbfdf','prf_8072738b47905','app_thentrlco','obj_90fa3b2d2e1f4','obj_04e024c3a91c2','2020-06-23 00:14:14.099548-05','2020-06-23 00:14:14.099548-05','2020-06-23 00:14:14.099548-05',1);
INSERT INTO public.messages (message_id,message_attributes,message_body,message_images,message_deleted,thread_id,profile_id,app_id,event_id,process_id,time_started,time_updated,time_finished,active) VALUES
	 ('msg_55f8f98ffaea1',NULL,'yeah I’m sitting outside',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_c8dca56c92788','obj_8531bab59b5a7','2020-06-25 11:47:39.258973-05','2020-06-25 11:47:39.258973-05','2020-06-25 11:47:39.258973-05',1),
	 ('msg_c3be22eda2627',NULL,'you here at Bread winners?',NULL,0,'thr_d1ed4f3f163e7','prf_4dd2cf3c19bc2','app_thentrlco','obj_11a9e4bfe7505','obj_bdb33d537379c','2020-06-25 11:47:00.783295-05','2020-06-25 11:47:00.783295-05','2020-06-25 11:47:00.783295-05',1),
	 ('msg_65332531e4145',NULL,'just fuckling work',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_2abaf5f5404f9','obj_b565caacce528','2020-10-14 20:46:25.691861-05','2020-10-14 20:46:25.691861-05','2020-10-14 20:46:25.691861-05',1),
	 ('msg_c1268c5aa6b9c',NULL,'a resource to be put into a database',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_5c1259eea262d','obj_6b227bd90a685','2020-10-14 21:01:11.096935-05','2020-10-14 21:01:11.096935-05','2020-10-14 21:01:11.096935-05',1),
	 ('msg_170201c4dc596',NULL,'Breakfast Was Amazing. Thanks, Boss!',NULL,0,'thr_d1ed4f3f163e7','prf_4dd2cf3c19bc2','app_thentrlco','obj_47aae76b5a778','obj_74d51be4c9823','2020-06-25 11:57:58.114422-05','2020-06-25 11:57:58.114422-05','2020-06-25 11:57:58.114422-05',1),
	 ('msg_dcd7f69d80272',NULL,'try now... a damn gain',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_7cf48ce8e26ff','obj_f0c970cea6c84','2020-10-14 21:30:00.746935-05','2020-10-14 21:30:00.746935-05','2020-10-14 21:30:00.746935-05',1),
	 ('msg_b29db65eb882d',NULL,'Breakfast Was Amazing. Thanks, Boss! [THIS IS DEFINITELY A DUPLICATE. THERE IS MORE TIME NEEDED TO COMPLETE THIS VIEW. PLEASE STAND BY. NEEDED LONGER TEXT STRING HERE FOR TESTING PURPOSES.]',NULL,0,'thr_d1ed4f3f163e7','prf_4dd2cf3c19bc2','app_thentrlco','obj_1226b986dbde2','obj_cdce11d3ce21a','2020-06-25 11:58:00.980196-05','2020-06-25 11:58:00.980196-05','2020-06-25 11:58:00.980196-05',1),
	 ('msg_e333341713c6a',NULL,'edededededwqd',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_3863541ab719f','obj_fdedbea0b78b5','2020-07-25 08:48:19.566696-05','2020-07-25 08:48:19.566696-05','2020-07-25 08:48:19.566696-05',1),
	 ('msg_6809a6d89d6f1',NULL,'try now',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_01ecf355dc576','obj_a98c01f13d2eb','2020-07-28 17:16:29.355389-05','2020-07-28 17:16:29.355389-05','2020-07-28 17:16:29.355389-05',1),
	 ('msg_a1e29a6ba60cb',NULL,'dkckejxjf',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_fcf259ad39c6b','obj_610e04e02a0fb','2020-07-28 18:03:50.978587-05','2020-07-28 18:03:50.978587-05','2020-07-28 18:03:50.978587-05',1);
INSERT INTO public.messages (message_id,message_attributes,message_body,message_images,message_deleted,thread_id,profile_id,app_id,event_id,process_id,time_started,time_updated,time_finished,active) VALUES
	 ('msg_fa0ddd085ed2e',NULL,'name',NULL,0,'thr_c89abf2a03059','prf_f18a6e657d71e','app_thentrlco','obj_03918434352d2','obj_1bd9408238aba','2020-08-16 10:43:30.54333-05','2020-08-16 10:43:30.54333-05','2020-08-16 10:43:30.54333-05',1),
	 ('msg_e8183bff03b5a',NULL,'name',NULL,0,'thr_c89abf2a03059','prf_f18a6e657d71e','app_thentrlco','obj_e43abe71bd759','obj_d578ca6a39bc4','2020-08-16 10:43:31.707506-05','2020-08-16 10:43:31.707506-05','2020-08-16 10:43:31.707506-05',1),
	 ('msg_73eda311f7af4',NULL,'1',NULL,0,'thr_c89abf2a03059','prf_f18a6e657d71e','app_thentrlco','obj_14392a15f16b2','obj_b2da0986ba450','2020-08-16 10:44:07.964603-05','2020-08-16 10:44:07.964603-05','2020-08-16 10:44:07.964603-05',1),
	 ('msg_b4d32c99f3d68',NULL,'1',NULL,0,'thr_c89abf2a03059','prf_f18a6e657d71e','app_thentrlco','obj_551d13441a4d7','obj_891557e3d5a4d','2020-08-16 10:44:09.365875-05','2020-08-16 10:44:09.365875-05','2020-08-16 10:44:09.365875-05',1),
	 ('msg_d5a2e13bc2cbb',NULL,'wait a minute',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_9d4bdee04e792','obj_f11d247c5ba3f','2020-10-09 17:48:12.511459-05','2020-10-09 17:48:12.511459-05','2020-10-09 17:48:12.511459-05',1),
	 ('msg_17aaa731a088e',NULL,'wait a minute',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_c08b6fa7d1aea','obj_62e9cc99b9eea','2020-10-09 17:48:14.995696-05','2020-10-09 17:48:14.995696-05','2020-10-09 17:48:14.995696-05',1),
	 ('msg_353ef506b6b19',NULL,'wait a minute',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_b473f1b673357','obj_f11a3b55fcf0f','2020-10-09 17:48:15.753259-05','2020-10-09 17:48:15.753259-05','2020-10-09 17:48:15.753259-05',1),
	 ('msg_c83cd51a9e947',NULL,'lessons',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_b7f31054ec499','obj_78806378e0507','2020-10-09 19:22:25.264172-05','2020-10-09 19:22:25.264172-05','2020-10-09 19:22:25.264172-05',1),
	 ('msg_51dda93d71f7e',NULL,'fctt',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_f3f8bfd017343','obj_1de6596ff577e','2020-10-09 19:24:50.102458-05','2020-10-09 19:24:50.102458-05','2020-10-09 19:24:50.102458-05',1),
	 ('msg_d23fb73baec02',NULL,'give me a break',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_c5e1c2071f899','obj_91565971ceb38','2020-10-09 19:31:47.748302-05','2020-10-09 19:31:47.748302-05','2020-10-09 19:31:47.748302-05',1);
INSERT INTO public.messages (message_id,message_attributes,message_body,message_images,message_deleted,thread_id,profile_id,app_id,event_id,process_id,time_started,time_updated,time_finished,active) VALUES
	 ('msg_1eb32b4649940',NULL,'give me a break',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_d9307e70e4f44','obj_950594cd259ef','2020-10-09 19:31:47.764263-05','2020-10-09 19:31:47.764263-05','2020-10-09 19:31:47.764263-05',1),
	 ('msg_14a2223dc3cd8',NULL,'what just happened ',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_58926fb5c38fc','obj_4b53576aaa147','2020-10-09 20:19:00.640727-05','2020-10-09 20:19:00.640727-05','2020-10-09 20:19:00.640727-05',1),
	 ('msg_a326dfe80151c',NULL,'ho ho ho',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_446ad5225877d','obj_d5a3a1a878053','2020-10-10 01:14:35.697734-05','2020-10-10 01:14:35.697734-05','2020-10-10 01:14:35.697734-05',1),
	 ('msg_dd287923ac181',NULL,'what on earth does this mean?',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_5ff6106ab88b0','obj_61f1762ebcba3','2020-10-10 01:15:13.476691-05','2020-10-10 01:15:13.476691-05','2020-10-10 01:15:13.476691-05',1),
	 ('msg_a39bd7b4456d7',NULL,'did it work',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_ce09da306ca45','obj_c324248a3ce55','2020-10-10 01:15:56.510949-05','2020-10-10 01:15:56.510949-05','2020-10-10 01:15:56.510949-05',1),
	 ('msg_1735760ac4dc2',NULL,'did it work',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_f115bc980958f','obj_ac0ea67977d3f','2020-10-10 01:16:05.245173-05','2020-10-10 01:16:05.245173-05','2020-10-10 01:16:05.245173-05',1),
	 ('msg_d8d067f44868d',NULL,'eicirjdnsnxjfjv',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_8bfac6a1b447d','obj_82bfdd8b883bf','2020-10-10 01:38:51.776022-05','2020-10-10 01:38:51.776022-05','2020-10-10 01:38:51.776022-05',1),
	 ('msg_6d5a23e6b3ee2',NULL,'fuck this shit',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_283d8138d480b','obj_3f27064c60957','2020-10-12 18:39:17.563956-05','2020-10-12 18:39:17.563956-05','2020-10-12 18:39:17.563956-05',1),
	 ('msg_1fac5688bcf46',NULL,'why is there refresh trippin',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_0e13f427dc28a','obj_1aaeda8a3cc22','2020-10-14 09:22:38.711102-05','2020-10-14 09:22:38.711102-05','2020-10-14 09:22:38.711102-05',1),
	 ('msg_1a8163765ac9c',NULL,'Are Puerto Rican’s American?',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_b86916aa05724','obj_cf8850605a5d8','2020-10-14 20:04:48.599828-05','2020-10-14 20:04:48.599828-05','2020-10-14 20:04:48.599828-05',1);
INSERT INTO public.messages (message_id,message_attributes,message_body,message_images,message_deleted,thread_id,profile_id,app_id,event_id,process_id,time_started,time_updated,time_finished,active) VALUES
	 ('msg_31cd87c6c108d',NULL,'Are Puerto Rican’s American?',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_14af61d0fead8','obj_d66a66d8cdedb','2020-10-14 20:04:50.149242-05','2020-10-14 20:04:50.149242-05','2020-10-14 20:04:50.149242-05',1),
	 ('msg_f0a8156f9fd93',NULL,'Are Puerto Ricans American?',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_817acd1e121f9','obj_164fb3b7c5857','2020-10-14 20:05:50.248245-05','2020-10-14 20:05:50.248245-05','2020-10-14 20:05:50.248245-05',1),
	 ('msg_936736dfc49d9',NULL,'Are Puerto Rican’s American?',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_b68de16426bf1','obj_52381b2723ad6','2020-10-14 20:06:25.22058-05','2020-10-14 20:06:25.22058-05','2020-10-14 20:06:25.22058-05',1),
	 ('msg_085fc4e9b1c37',NULL,'🤷🏾‍♀️','{}',0,'thr_ed13f9cd3246d','prf_a6b3c606b1ccb','app_thentrlco','obj_041cead925885','obj_3c5df876a64ed','2020-10-14 20:06:43.740698-05','2020-10-14 20:06:43.740698-05','2020-10-14 20:06:43.740698-05',1),
	 ('msg_ddd189ad27d08',NULL,'Sunday play.',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_a4feb76acc743','obj_96d63763de68e','2020-10-14 20:16:09.136846-05','2020-10-14 20:16:09.136846-05','2020-10-14 20:16:09.136846-05',1),
	 ('msg_8819cc1c2f802',NULL,'Liv is pretty upset about waking up...',NULL,0,'thr_f4fd6b007647c','prf_al','app_thentrlco','obj_858b99050589b','obj_a4ddbf86aea93','2020-10-14 20:18:42.477335-05','2020-10-14 20:18:42.477335-05','2020-10-14 20:18:42.477335-05',1),
	 ('msg_3ed810f7e35c2',NULL,'I’m about to get some rest.',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_422c2f8430322','obj_f0a04499b2f7c','2020-10-14 23:16:37.658898-05','2020-10-14 23:16:37.658898-05','2020-10-14 23:16:37.658898-05',1),
	 ('msg_48ef23b7ef131',NULL,'try tgat shot now',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_a8d823ad5ff14','obj_bf873e12bc89f','2020-10-15 07:35:14.874877-05','2020-10-15 07:35:14.874877-05','2020-10-15 07:35:14.874877-05',1),
	 ('msg_91e4965a8fde7',NULL,'no',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_08380009ca428','obj_fa7826bf7141d','2020-10-28 09:39:24.607218-05','2020-10-28 09:39:24.607218-05','2020-10-28 09:39:24.607218-05',1),
	 ('msg_0cfc9e598d93e',NULL,'wait a minute ',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_cdf5b843a3023','obj_10e2d55decae7','2020-10-29 09:17:10.538213-05','2020-10-29 09:17:10.538213-05','2020-10-29 09:17:10.538213-05',1);
INSERT INTO public.messages (message_id,message_attributes,message_body,message_images,message_deleted,thread_id,profile_id,app_id,event_id,process_id,time_started,time_updated,time_finished,active) VALUES
	 ('msg_89819ab79781f',NULL,'try it now.',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_ad0f5c561a761','obj_cccd381624f36','2020-10-31 08:04:04.732745-05','2020-10-31 08:04:04.732745-05','2020-10-31 08:04:04.732745-05',1),
	 ('msg_63bae95c7fdf0',NULL,'I can’t breath.',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_e57f541e631f4','obj_ac055eba4d253','2020-10-31 13:19:42.875386-05','2020-10-31 13:19:42.875386-05','2020-10-31 13:19:42.875386-05',1),
	 ('msg_4ac049b1eee92',NULL,'try is as anthony',NULL,0,'thr_d1ed4f3f163e7','prf_4dd2cf3c19bc2','app_thentrlco','obj_4e40ab2c62fa4','obj_7819c286ccd78','2020-10-31 14:10:59.86304-05','2020-10-31 14:10:59.86304-05','2020-10-31 14:10:59.86304-05',1),
	 ('msg_3913b2ff122ef',NULL,'yo',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_86980e5d56d56','obj_188069739a33e','2020-10-31 14:14:36.917139-05','2020-10-31 14:14:36.917139-05','2020-10-31 14:14:36.917139-05',1),
	 ('msg_5791204a7981f',NULL,'trey thidflll',NULL,0,'thr_d1ed4f3f163e7','prf_8072738b47905','app_thentrlco','obj_b35d9a0fb2e4c','obj_75f14004bd773','2020-10-31 14:16:16.555622-05','2020-10-31 14:16:16.555622-05','2020-10-31 14:16:16.555622-05',1),
	 ('msg_2602d07d561b2',NULL,'nebraska',NULL,0,'thr_d1ed4f3f163e7','prf_4dd2cf3c19bc2','app_thentrlco','obj_5b5cc1fbca441','obj_1f6ee503df069','2020-11-02 08:49:08.79451-06','2020-11-02 08:49:08.79451-06','2020-11-02 08:49:08.79451-06',1);


	 INSERT INTO public.threads (thread_id,thread_attributes,thread_title,thread_participants,thread_preview,profile_id,app_id,event_id,process_id,time_started,time_updated,time_finished,active) VALUES
	 ('30 characters','{}','255 characters','{}','255 characters','30 characters','30 characters','30 characters','30 characters','2020-06-20 18:04:11.032229-05','2020-06-20 18:04:11.032229-05','2020-06-20 18:04:11.032229-05',1),
	 ('thr_c21056ffe3f0d',NULL,NULL,'{"blocked": [], "contributors": ["prf_0b9f8467d0bd4", "prf_8072738b47905"], "administrators": ["prf_8072738b47905"]}','Is this like an old man quiz?','prf_8072738b47905','app_thentrlco','obj_d4197f64a5139','obj_3273b32d14181','2020-06-22 22:54:08.462105-05','2020-06-22 22:54:08.462105-05','2020-06-22 22:54:08.462105-05',1),
	 ('thr_1276f9be89303',NULL,NULL,'{"blocked": [], "contributors": ["prf_3338ad7722aee", "prf_8072738b47905"], "administrators": ["prf_8072738b47905"]}','I''m not the only one feeling this way.','prf_8072738b47905','app_thentrlco','obj_17a0f891282c2','obj_549283f52ea08','2020-06-22 22:31:23.740407-05','2020-06-22 22:31:23.740407-05','2020-06-22 22:31:23.740407-05',1),
	 ('thr_d86ccf10688f9',NULL,'Just Al & Elk','{"contributors": ["prf_8072738b47905", "prf_ca350aa93607a"], "adminstrators": ["prf_8072738b47905"]}','How did you get access to this place?','prf_8072738b47905','app_thentrlco','obj_e05ff357b21b6','obj_42151eea95098','2020-06-20 18:37:00.55265-05','2020-06-20 18:37:00.55265-05','2020-06-20 18:37:00.55265-05',1),
	 ('thr_d1ed4f3f163e7',NULL,NULL,'{"blocked": [], "contributors": ["prf_4dd2cf3c19bc2", "prf_8072738b47905"], "administrators": ["null"]}','I want to show you something.','prf_8072738b47905','app_thentrlco','obj_50e0d31c9a185','obj_0903b6bfc8ba1','2020-06-25 11:46:40.101188-05','2020-06-25 11:46:40.101188-05','2020-06-25 11:46:40.101188-05',1),
	 ('thr_b73f7ac46356d',NULL,NULL,'{"blocked": [], "contributors": ["prf_b6aef83f838cc", "prf_8072738b47905"], "administrators": ["prf_8072738b47905"]}','Wendy may have taken an interest in me to fuck with you.','prf_8072738b47905','app_thentrlco','obj_83fca1660d241','obj_aa31dfe443c92','2020-06-22 20:52:47.07909-05','2020-06-22 20:52:47.07909-05','2020-06-22 20:52:47.07909-05',1),
	 ('thr_74dfdb69d47f9',NULL,NULL,'{"blocked": [], "contributors": ["prf_8072738b47905", "prf_76a515da39522"], "administrators": ["prf_8072738b47905"]}','How good is Wendy at regular games?','prf_8072738b47905','app_thentrlco','obj_e90089ad343a1','obj_5ee96f10582ee','2020-06-22 22:50:37.806953-05','2020-06-22 22:50:37.806953-05','2020-06-22 22:50:37.806953-05',1),
	 ('thr_5a017dd89c36a',NULL,NULL,'{"blocked": [], "contributors": ["prf_8072738b47905", "prf_0b9f8467d0bd4"], "administrators": ["prf_8072738b47905"]}','Do not get in the middle of this.','prf_8072738b47905','app_thentrlco','obj_f623038682aec','obj_92bb97b89f174','2020-06-22 20:50:22.494761-05','2020-06-22 20:50:22.494761-05','2020-06-22 20:50:22.494761-05',1),
	 ('thr_f4fd6b007647c',NULL,'','{"contributors": ["prf_al", "prf_liv"], "administrators": ["prf_al"]}',NULL,'prf_al','app_thentrlco','obj_65fd464d466b9','obj_4d023c7e20983','2020-10-14 20:18:42.34125-05','2020-10-14 20:18:42.34125-05','2020-10-14 20:18:42.34125-05',1),
	 ('thr_9209931912afc',NULL,NULL,'{"blocked": [], "contributors": ["prf_78be19a880cbc", "prf_8072738b47905"], "administrators": ["prf_8072738b47905"]}','How smart is Wendy Rhoades?','prf_8072738b47905','app_thentrlco','obj_768f32c9fe0a5','obj_1df2ed9ff5e00','2020-06-22 22:47:05.479836-05','2020-06-22 22:47:05.479836-05','2020-06-22 22:47:05.479836-05',1);
INSERT INTO public.threads (thread_id,thread_attributes,thread_title,thread_participants,thread_preview,profile_id,app_id,event_id,process_id,time_started,time_updated,time_finished,active) VALUES
	 ('thr_3f89d732a00ec',NULL,'two unknowns','{"contributors": ["prf_ca350aa3607a", "prf_a6b3c606b1ccb"], "adminstrators": ["prf_ca350aa93607a"]}','...but limit her.','prf_ca350aa93607a','app_thentrlco','obj_6ea1d326b45d0','obj_b3d10c6834b86','2020-06-22 09:12:36.778381-05','2020-06-22 09:12:36.778381-05','2020-06-22 09:12:36.778381-05',1),
	 ('thr_fdf747b1ba25e',NULL,'Just Al & Howard','{"contributors": ["prf_8072738b47905", "prf_6bab84ca976f0"], "adminstrators": ["prf_8072738b47905"]}','Come this way.','prf_8072738b47905','app_thentrlco','obj_ac0dec109e12a','obj_b2019d4152220','2020-06-20 18:37:23.093055-05','2020-06-20 18:37:23.093055-05','2020-06-20 18:37:23.093055-05',1),
	 ('thr_be10f23a2ffb6',NULL,'Just Al & Elsa','{"contributors": ["prf_8072738b47905", "prf_a6b3c606b1ccb"], "adminstrators": ["prf_8072738b47905"]}','I know some people','prf_8072738b47905','app_thentrlco','obj_2b7923afcd432','obj_4c248f532fba4','2020-06-20 18:36:38.934783-05','2020-06-20 18:36:38.934783-05','2020-06-20 18:36:38.934783-05',1),
	 ('thr_62999367fe651',NULL,NULL,'{"blocked": [], "contributors": ["prf_8072738b47905", "prf_ce1212333ac70"], "administrators": ["prf_8072738b47905"]}','And because we know that... all of us know that.','prf_8072738b47905','app_thentrlco','obj_b60061278a359','obj_e9f3d445cd412','2020-06-22 20:52:30.270006-05','2020-06-22 20:52:30.270006-05','2020-06-22 20:52:30.270006-05',1),
	 ('thr_2b430b2d4dfad',NULL,NULL,'{"blocked": [], "contributors": ["prf_8072738b47905", "prf_648a3ec68644a"], "administrators": ["prf_8072738b47905"]}','You asked me not to jump ahead.','prf_8072738b47905','app_thentrlco','obj_e105ba35c4a7c','obj_f1926ef2f8004','2020-06-22 22:45:10.935017-05','2020-06-22 22:45:10.935017-05','2020-06-22 22:45:10.935017-05',1),
	 ('thr_aa054bd0664d7',NULL,NULL,'{"blocked": [], "contributors": ["prf_8072738b47905", "prf_b3badb48a4936"], "administrators": ["prf_8072738b47905"]}','Blind...  period','prf_8072738b47905','app_thentrlco','obj_6a438a8aba2d2','obj_c9181d0ebe069','2020-06-22 22:04:22.248769-05','2020-06-22 22:04:22.248769-05','2020-06-22 22:04:22.248769-05',1),
	 ('thr_c89abf2a03059',NULL,NULL,'{"blocked": [], "contributors": ["prf_f18a6e657d71e", "prf_ce1212333ac70"], "administrators": ["prf_f18a6e657d71e"]}',NULL,'prf_f18a6e657d71e','app_thentrlco','obj_fb2d645403ec9','obj_6b1a929fdf196','2020-08-16 10:42:48.137986-05','2020-08-16 10:42:48.137986-05','2020-08-16 10:42:48.137986-05',1),
	 ('thr_ed13f9cd3246d',NULL,'Just Elsa & Elk','{"contributors": ["prf_ca350aa93607a", "prf_a6b3c606b1ccb"], "adminstrators": ["prf_ca350aa93607a"]}','Anything more and you''re giving away too much ownership.','prf_ca350aa93607a','app_thentrlco','obj_bc12127a78124','obj_a57470296cd98','2020-06-20 19:33:44.11172-05','2020-06-20 19:33:44.11172-05','2020-06-20 19:33:44.11172-05',1),
	 ('thr_067b4cc8cbfdf',NULL,'Just Al & Mr. Speaker','{"contributors": ["prf_8072738b47905", "prf_71a6327f41860"], "adminstrators": ["prf_3338ad7722aee"]}','Smart overcomplicated women.','prf_8072738b47905','app_thentrlco','obj_0ce56d40db76a','obj_2126f54f121fc','2020-06-20 18:30:07.896623-05','2020-06-20 18:30:07.896623-05','2020-06-20 18:30:07.896623-05',1),
	 ('thr_1e7e7b5fcb9ee',NULL,NULL,'{"blocked": [], "contributors": ["prf_8072738b47905", "prf_fcd1cc0aeabb4"], "administrators": ["prf_8072738b47905"]}','You have nothing to worry about.','prf_8072738b47905','app_thentrlco','obj_1c29fd7ebc7bc','obj_d25002e1a61f9','2020-06-22 22:23:12.769952-05','2020-06-22 22:23:12.769952-05','2020-06-22 22:23:12.769952-05',1);

	 