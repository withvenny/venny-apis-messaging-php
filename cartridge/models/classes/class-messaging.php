<?php

    //
    namespace Messaging;

    //
    class Connection {
    
        /**
         * Connection
         * @var type 
         */
        private static $conn;
    
        /**
         * Connect to the database and return an instance of \PDO object
         * @return \PDO
         * @throws \Exception
         */
        public function connect() {

            // read parameters in the ini configuration file
            //$params = parse_ini_file('database.ini');
            $db = parse_url(getenv("DATABASE_URL"));

            //if ($params === false) {throw new \Exception("Error reading database configuration file");}
            if ($db === false) {throw new \Exception("Error reading database configuration file");}
            // connect to the postgresql database
            $conStr = sprintf("pgsql:host=%s;port=%d;dbname=%s;user=%s;password=%s", 
                    $db['host'],
                    $db['port'], 
                    ltrim($db["path"], "/"), 
                    $db['user'], 
                    $db['pass']);
    
            $pdo = new \PDO($conStr);
            $pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
    
            return $pdo;
        }
    
        /**
         * return an instance of the Connection object
         * @return type
         */
        public static function get() {
            if (null === static::$conn) {
                static::$conn = new static();
            }
    
            return static::$conn;
        }
    
        protected function __construct() {
            
        }
    
        private function __clone() {
            
        }
    
        private function __wakeup() {
            
        }
    
    }

    //
    class Token {

        /**
         * PDO object
         * @var \PDO
         */
        private $pdo;
    
        /**
         * init the object with a \PDO object
         * @param type $pdo
         */
        public function __construct($pdo) {
            $this->pdo = $pdo;
        }

        /**
         * Return all rows in the stocks table
         * @return array
         */
        public function all() {
            $stmt = $this->pdo->query('SELECT id, symbol, company '
                    . 'FROM stocks '
                    . 'ORDER BY symbol');
            $stocks = [];
            while ($row = $stmt->fetch(\PDO::FETCH_ASSOC)) {
                $stocks[] = [
                    'id' => $row['id'],
                    'symbol' => $row['symbol'],
                    'company' => $row['company']
                ];
            }
            return $stocks;
        }

        //
        public function validatedToken() {
            
            //
            return true;
            
            //exit;

        }

        //
        public function process_id($object='obj') {

            //
            $id = substr(md5(uniqid(microtime(true),true)),0,13);

            $id = $object.'_'.$id;

            //
            return $id;
            
            //exit;

        }
        
        //
        public function event_id($object='obj') {

            //
            $id = substr(md5(uniqid(microtime(true),true)),0,13);

            $id = $object.'_'.$id;
    
            //
            return $id;
            
            //exit;

        }

        //
        public function new_id($object='obj') {

            //
            $id = substr(md5(uniqid(microtime(true),true)),0,13);
            $id = $object . "_" . $id;
    
            //
            return $id;
            
            //exit;

        }

        /**
         * Find stock by id
         * @param int $id
         * @return a stock object
         */
        public function check($id) {

            //
            $sql = "SELECT message_id FROM messages WHERE id = :id AND active = 1";

            // prepare SELECT statement
            $statement = $this->pdo->prepare($sql);
            // bind value to the :id parameter
            $statement->bindValue(':id', $id);
            
            // execute the statement
            $stmt->execute();
    
            // return the result set as an object
            return $stmt->fetchObject();
        }

        /**
         * Delete a row in the stocks table specified by id
         * @param int $id
         * @return the number row deleted
         */
        public function delete($id) {
            $sql = 'DELETE FROM stocks WHERE id = :id';
    
            $stmt = $this->pdo->prepare($sql);
            $stmt->bindValue(':id', $id);
    
            $stmt->execute();
    
            return $stmt->rowCount();
        }

        /**
         * Delete all rows in the stocks table
         * @return int the number of rows deleted
         */
        public function deleteAll() {
    
            $stmt = $this->pdo->prepare('DELETE FROM stocks');
            $stmt->execute();
            return $stmt->rowCount();
        }

    }

    //
    class Thread {

        //
        private $pdo;
    
        //
        public function __construct($pdo) {

            //
            $this->pdo = $pdo;

            //
            $this->token = new \Messaging\Token($this->pdo);

        }

        //
        public function insertThread($request) {

            //generate ID
            if(!isset($request['id'])){$request['id'] = $this->token->new_id('thr');}

            $columns = "";

            // INSERT OBJECT - COLUMNS
            if(isset($request['id'])){$columns.="thread_id,";}
            if(isset($request['attributes'])){$columns.="thread_attributes,";}
            if(isset($request['title'])){$columns.="thread_title,";}
            if(isset($request['participants'])){$columns.="thread_participants,";}
            if(isset($request['preview'])){$columns.="thread_preview,";}
            if(isset($request['profile'])){$columns.="profile_id,";}

            $columns.= "app_id,";
            $columns.= "event_id,";
            $columns.= "process_id";

            $values = "";

            // INSERT OBJECT - VALUES
            if(isset($request['id'])){$values.=":thread_id,";}
            if(isset($request['attributes'])){$values.=":thread_attributes,";}
            if(isset($request['title'])){$values.=":thread_title,";}
            if(isset($request['participants'])){$values.=":thread_participants,";}
            if(isset($request['preview'])){$values.=":thread_preview,";}
            if(isset($request['profile'])){$values.=":profile_id,";}

            $values.= ":app_id,";
            $values.= ":event_id,";
            $values.= ":process_id";

            // prepare statement for insert
            $sql = "INSERT INTO {$request['domain']} (";
            $sql.= $columns;
            $sql.= ") VALUES (";
            $sql.= $values;
            $sql.= ")";
            $sql.= " RETURNING " . prefixed($request['domain']) . "_id";
    
            //
            $statement = $this->pdo->prepare($sql);
            
            // INSERT OBJECT - BIND VALUES
            if(isset($request['id'])){$statement->bindValue('thread_id',$request['id']);}
            if(isset($request['attributes'])){$statement->bindValue('thread_attributes',$request['attributes']);}
            if(isset($request['title'])){$statement->bindValue('thread_title',$request['title']);}
            if(isset($request['participants'])){$statement->bindValue('thread_participants',$request['participants']);}
            if(isset($request['preview'])){$statement->bindValue('thread_preview',$request['preview']);}
            if(isset($request['profile'])){$statement->bindValue('profile_id',$request['profile']);}

            $statement->bindValue(':app_id', $request['app']);
            $statement->bindValue(':event_id', $this->token->event_id());
            $statement->bindValue(':process_id', $this->token->process_id());
            
            // execute the insert statement
            $statement->execute();

            $data = $statement->fetchAll();
            
            $data = $data[0]['thread_id'];

            //echo json_encode($data); exit;

            return $data;
        
        }

        //
        public function selectThreads($request) {

            //echo json_encode($request); exit;

            //$token = new \Core\Token($this->pdo);
            $token = $this->token->validatedToken($request['token']);

            // Retrieve data ONLY if token  
            if($token) {
                
                // domain, app always present
                if(!isset($request['per'])){$request['per']=20;}
                if(!isset($request['page'])){$request['page']=1;}
                if(!isset($request['limit'])){$request['limit']=100;}

                //
                $conditions = "";
                $domain = $request['domain'];
                $prefix = prefixed($domain);

                // SELECT OBJECT - COLUMNS
                $columns = "

                    thread_ID,
                    thread_attributes,
                    thread_title,
                    thread_participants,
                    thread_preview,
                    profile_ID,
                    app_ID,
                    time_updated,
                    time_finished

                ";

                $table = $domain;

                //
                $start = 0;

                //
                if(isset($request['page'])) {

                    //
                    $start = ($request['page'] - 1) * $request['per'];
                
                }

                //
                if(!empty($request['id'])) {

                    $conditions.= ' WHERE ';
                    $conditions.= ' ' . $prefix . '_id = :id ';
                    $conditions.= ' AND active = 1 ';
                    $conditions.= ' ORDER BY time_finished DESC ';

                    $subset = " LIMIT 1";

                    $sql = "SELECT ";
                    $sql.= $columns;
                    $sql.= " FROM " . $table;
                    $sql.= $conditions;
                    $sql.= $subset;
                    
                    //echo json_encode($request['id']);
                    //echo '<br/>';
                    //echo $sql; exit;

                    //
                    $statement = $this->pdo->prepare($sql);

                    // bind value to the :id parameter
                    $statement->bindValue(':id', $request['id']);

                    //echo $sql; exit;
                
                } elseif(!empty($request['profile'])) {

                    //
                    //$participants = json_decode($request['participants'], true);
    
                    $conditions.= ' WHERE ';
                    $conditions.= 'thread_participants ->\'contributors\' @> \''. json_encode($request['profile']) . '\'::jsonb';
                    //$conditions.= ' ' . $prefix . '_id = :id ';
                    $conditions.= ' AND active = 1 ';
                    $conditions.= ' ORDER BY time_finished DESC ';
    
                    //$subset = " LIMIT 1";
    
                    $sql = "SELECT ";
                    $sql.= $columns;
                    $sql.= " FROM " . $table;
                    $sql.= $conditions;
                    //$sql.= $subset;
                    
                    //echo json_encode($request['participants']['contributors']);
                    //echo '<br/>';
                    //echo $sql; exit;
    
                    //
                    $statement = $this->pdo->prepare($sql);
    
                    // bind value to the :id parameter
                    //$statement->bindValue(':id', $request['id']);
    
                    //echo $sql; exit;
                } else {

                    $conditions = "";
                    $refinements = "";

                    // SELECT OBJECT - WHERE CLAUSES
                    // SKIP ID
                    if(isset($request['attributes'])){$refinements.="thread_attributes"." ILIKE "."'%".$request['attributes']."%' AND ";}
                    if(isset($request['title'])){$refinements.="thread_title"." ILIKE "."'%".$request['title']."%' AND ";}
                    //if(isset($request['participants'])){$refinements.="thread_participants"." ILIKE "."'%".$request['participants']."%' AND ";}
                    if(isset($request['preview'])){$refinements.="thread_preview"." ILIKE "."'%".$request['preview']."%' AND ";}

                    //echo $conditions . 'conditions1<br/>';
                    //echo $refinements . 'refinements1<br/>';
                    
                    $conditions.= " WHERE ";
                    $conditions.= $refinements;
                    $conditions.= " active = 1 ";
                    $conditions.= ' AND app_id = \'' . $request['app'] . '\' ';
                    $conditions.= ' AND profile_id = \'' . $request['profile'] . '\' ';
                    $conditions.= " ORDER BY time_finished DESC ";
                    $subset = " OFFSET {$start}" . " LIMIT {$request['per']}";
                    $sql = "SELECT ";
                    $sql.= $columns;
                    $sql.= "FROM " . $table;
                    $sql.= $conditions;
                    //$sql.= $subset;

                    //echo $conditions . 'conditions2<br/>';
                    //echo $refinements . 'refinements2<br/>';

                    //echo $sql; exit;
                    
                    //
                    $statement = $this->pdo->prepare($sql);

                }
                    
                // execute the statement
                $statement->execute();

                //
                $results = [];
                $total = $statement->rowCount();
                $pages = ceil($total/$request['per']); //
                //$current = 1; // current page
                //$limit = $result['limit'];
                //$max = $result['max'];

                //
                if($statement->rowCount() > 0) {

                    //
                    $data = array();
                
                    //
                    while($row = $statement->fetch(\PDO::FETCH_ASSOC)) {

                        $contributors=[];

                        /*
                        $api = "https://io-venny-api.herokuapp.com/profiles?app=app_thentrlco&token=tkn_thentrlco&profile=prf_8072738b47905&id=" . $row['profile_id'];
                        $json = file_get_contents($api);
                        $json = json_decode($json,true);

                        array_push(
                            $contributors,
                            $json['data'][0]
                        );

                        echo json_encode($contributors);
                        exit;
                        */

                        /*
                        echo json_encode($row['profile_id']);
                        $left = json_encode($row['thread_participants']);
                        echo json_decode($left);
                        echo json_decode($left[0]);
                        echo json_decode($left['contributors'],true);
                        exit;
                        */

                        $participants = json_decode($row['thread_participants']);

                        //echo var_dump($participants);
                        //echo var_dump($participants->contributors);
                        //exit;

                        foreach($participants->contributors as $contributor) {
                        //for($row = 0; $row < 4; $row++) {

                            //echo "I/'m in...";
                            //exit;

                            /*
                            $fruits = array ("Orange", "Apple", "Banana",  "Cherry", " Mango");
                            foreach ( $fruits as $value ) {
                                echo  "$value<br />";
                            }
                            */

                            $response = "https://io-venny-api.herokuapp.com/profiles?app=app_thentrlco&token=tkn_thentrlco&profile=prf_8072738b47905&id=" . $contributor;
                            $profile = file_get_contents($response);
                            $profile = stripslashes(json_encode($profile,JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES));

                            //echo $profile;
                            //exit;

                            // Declare a json string 
                            //$json = '{"geeks": 7551119,"greetings":["hi","hello","hey"]}'; 
                            //$profiles = '{"status":200,"message":"SUCCESSFUL","data":[{"id":"prf_8072738b47905","attributes":null,"images":{"profile":{"list":["img_0001","img_0002","img_0003","img_0004"],"default":"img_0001"},"cover":{"list":["img_0005","img_0006","img_0007","img_0008"],"default":"img_0005"}},"bio":"I\'m just Adolphus...","headline":"The spirits then vanished","access":"public","status":"live","user":"usr_94b64ffe1g12d","app":"app_thentrlco","when":"2020-04-21 02:09:23.884457+00","name_first":"adolphus","name_last":"nolan","alias":"sonofadolphus"}]}'; 
                            //$threads = '{"status":200,"message":"SUCCESSFUL","data":[{"id":"thr_0001","participants":{"blocked":[],"contributors":["prf_0001","prf_0002","prf_0003"],"administrators":["prf_0001"]}}]}';

                            // Use json_decode() function to 
                            // decode a string 
                            //$profile = json_decode($profiles); 
                            //$thread = json_decode($threads); 

                            // Display the value of json object 
                            //$data = $thread->data;
                            //echo var_dump($data);

                            //$participants = $data[0]->participants;
                            //echo var_dump($participants);

                            //echo print_r(json_decode($profile));
                            //echo $profile->{'log'};
                            //echo $profile->log;
                            //echo $profile['log']['process'];
                            //echo var_dump($profile['log']);
                            //echo var_dump(json_decode($profile));
                            //echo print_r(json_decode($profile->data));
                            //echo print_r(json_encode($profile['data'][0]));
                            //exit;

                            $contributor_id=json_encode($profile->data[0]->id);
                            $contributor_images=json_encode($profile->data[0]->images);
                            $contributor_alias=json_encode($profile->data[0]->alias);
    
                            array_push(
                                $contributors,
                                array(
                                    'id'=>$contributor_id,
                                    'images'=>$contributor_images,
                                    'alias'=>$contributor_alias
                                )
                            );

                        };

                        //echo print_r($contributors);
                        //exit;
        
                        //
                        $data[] = [

                            'id' => $row['thread_id'],
                            'attributes' => json_decode($row['thread_attributes']),
                            'title' => $row['thread_title'],
                            'participants' => json_decode($row['thread_participants']),
                            'contributors' => $contributors,
                            'preview' => $row['thread_preview'],
                            'profile' => $row['profile_id'],
                            'app' => $row['app_id'],
                            'when' => $row['time_finished'],
                            'updated' => $row['time_updated']

                        ];

                    }

                    //$api = "https://io-venny-api.herokuapp.com/profiles?app=app_thentrlco&token=tkn_thentrlco&profile=prf_8072738b47905&id=prf_8072738b47905";

                    //$json = file_get_contents($api);
                    //$json = json_decode($json,true);

                    $code = 200;
                    $message = "OK";

                } else {

                    //
                    $data = NULL;
                    $code = 204;
                    $message = "No Content";

                }

            } else {

                //
                $data[] = NULL;
                $code = 401;
                $message = "Forbidden - Valid token required";

            }

            $results = array(

                'status' => $code,
                'message' => $message,
                'metadata' => [
                    'page' => $request['page'],
                    'pages' => $pages,
                    'total' => $total
                ],
                'data' => $data,
                //'json' => $json['data'][0],
                'log' => [
                    'process' => $process_id = $this->token->process_id(),
                    'event' => $event_id = $this->token->event_id($process_id)
                ]

            );

            //
            return $results;

        }

        //
        public function updateThread($request) {

            //
            $domain = $request['domain'];
            $table = prefixed($domain);
            $id = $request['id'];

            //
            $set = "";

            // UPDATE OBJECT - SET
            //if(isset($request['id'])){$set.= " thread_id = :thread_id ";}
            if(isset($request['attributes'])){$set.= " thread_attributes = :thread_attributes ";}
            if(isset($request['title'])){$set.= " thread_title = :thread_title ";}
            if(isset($request['participants'])){$set.= " thread_participants = :thread_participants ";}
            if(isset($request['preview'])){$set.= " thread_preview = :thread_preview ";}
            //if(isset($request['profile'])){$set.= " profile_id = :profile_id ";}

            //
            $set = str_replace('  ',',',$set);

            // GET table name
            $condition = $table."_id = :id";
            $condition.= " RETURNING " . $table . "_id";

            // sql statement to update a row in the stock table
            $sql = "UPDATE {$domain} SET ";
            $sql.= $set;
            $sql.= " WHERE ";
            $sql.= $condition;

            //echo $sql; exit;

            $statement = $this->pdo->prepare($sql);
    
            // UPDATE OBJECT - BIND VALUES
            //if(isset($request['id'])){$statement->bindValue(':thread_id', $request['id']);}
            if(isset($request['attributes'])){$statement->bindValue(':thread_attributes', $request['attributes']);}
            if(isset($request['title'])){$statement->bindValue(':thread_title', $request['title']);}
            if(isset($request['participants'])){$statement->bindValue(':thread_participants', $request['participants']);}
            if(isset($request['preview'])){$statement->bindValue(':thread_preview', $request['preview']);}
            //if(isset($request['profile'])){$statement->bindValue(':profile_id', $request['profile']);}
            //if(isset($request['app'])){$statement->bindValue(':app_id', $request['app']);}

            $statement->bindValue(':id', $id);

            // update data in the database
            $statement->execute();

            $data = $statement->fetchAll();
            
            $data = $data[0]['thread_id'];

            // return generated id
            return $data;

        }

        //
        public function deleteThread($request) {

            $id = $request['id'];
            $domain = $request['domain'];
            $column = prefixed($domain) . '_id';
            $sql = 'DELETE FROM ' . $domain . ' WHERE '.$column.' = :id';
            //echo $id; //exit
            //echo $column; //exit;
            //echo $domain; //exit;
            //echo $sql; //exit

            $statement = $this->pdo->prepare($sql);
            //$statement->bindParam(':column', $column);
            $statement->bindValue(':id', $id);
            $statement->execute();
            return $statement->rowCount();

        }

    }

    //
    class Message {

        //
        private $pdo;
    
        //
        public function __construct($pdo) {

            //
            $this->pdo = $pdo;

            //
            $this->token = new \Messaging\Token($this->pdo);

        }

        //
        public function insertMessage($request) {

            //generate ID
            if(!isset($request['id'])){$request['id'] = $this->token->new_id('msg');}

            $columns = "";

            // INSERT OBJECT - COLUMNS
            if(isset($request['id'])){$columns.="message_id,";}		
            if(isset($request['attributes'])){$columns.="message_attributes,";}		
            if(isset($request['body'])){$columns.="message_body,";}		
            if(isset($request['images'])){$columns.="message_images,";}		
            if(isset($request['deleted'])){$columns.="message_deleted,";}
            if(isset($request['profile'])){$columns.="profile_id,";}
            if(isset($request['thread'])){$columns.="thread_id,";}

            $columns.= "app_id,";
            $columns.= "event_id,";
            $columns.= "process_id";

            $values = "";

            // INSERT OBJECT - VALUES
            if(isset($request['id'])){$values.=":message_id,";}
            if(isset($request['attributes'])){$values.=":message_attributes,";}
            if(isset($request['body'])){$values.=":message_body,";}
            if(isset($request['images'])){$values.=":message_images,";}
            if(isset($request['deleted'])){$values.=":message_deleted,";}
            if(isset($request['profile'])){$values.=":profile_id,";}
            if(isset($request['thread'])){$values.=":thread_id,";}

            $values.= ":app_id,";
            $values.= ":event_id,";
            $values.= ":process_id";

            // prepare statement for insert
            $sql = "INSERT INTO {$request['domain']} (";
            $sql.= $columns;
            $sql.= ") VALUES (";
            $sql.= $values;
            $sql.= ")";
            $sql.= " RETURNING " . prefixed($request['domain']) . "_id";
    
            //
            $statement = $this->pdo->prepare($sql);
            
            // INSERT OBJECT - BIND VALUES
            if(isset($request['id'])){$statement->bindValue('message_id',$request['id']);}
            if(isset($request['attributes'])){$statement->bindValue('message_attributes',$request['attributes']);}
            if(isset($request['body'])){$statement->bindValue('message_body',$request['body']);}
            if(isset($request['images'])){$statement->bindValue('message_images',$request['images']);}
            if(isset($request['deleted'])){$statement->bindValue('message_deleted',$request['deleted']);}
            if(isset($request['profile'])){$statement->bindValue('profile_id',$request['profile']);}
            if(isset($request['thread'])){$statement->bindValue('thread_id',$request['thread']);}

            $statement->bindValue(':app_id', $request['app']);
            $statement->bindValue(':event_id', $this->token->event_id());
            $statement->bindValue(':process_id', $this->token->process_id());
            
            // execute the insert statement
            $statement->execute();

            $data = $statement->fetchAll();
            
            $data = $data[0]['message_id'];

            return $data;

        }

        //
        public function selectMessages($request) {

            //echo json_encode($request); exit;

            //$token = new \Core\Token($this->pdo);
            $token = $this->token->validatedToken($request['token']);

            // Retrieve data ONLY if token  
            if($token) {
                
                // domain, app always present
                if(!isset($request['per'])){$request['per']=20;}
                if(!isset($request['page'])){$request['page']=1;}
                if(!isset($request['limit'])){$request['limit']=100;}

                //
                $conditions = "";
                $domain = $request['domain'];
                $prefix = prefixed($domain);

                //
                $columns = "

                    message_id,
                    message_attributes,
                    message_body,
                    message_images,
                    message_deleted,
                    thread_id,
                    profile_id,
                    app_id,
                    time_updated,
                    time_finished

                ";

                $table = $domain;

                //
                $start = 0;

                //
                if(isset($request['page'])) {

                    //
                    $start = ($request['page'] - 1) * $request['per'];
                
                }

                //
                if(!empty($request['id'])) {

                    $conditions.= " WHERE";
                    $conditions.= " " . $prefix . "_id = :id ";
                    $conditions.= " AND active = 1 ";
                    $conditions.= " ORDER BY time_finished DESC ";
                    
                    $subset = " LIMIT 1";

                    $sql = "SELECT ";
                    $sql.= $columns;
                    $sql.= " FROM " . $table;
                    $sql.= $conditions;
                    $sql.= $subset;
                    
                    //echo json_encode($request['id']);
                    //echo '<br/>';
                    //echo $sql; exit;

                    //
                    $statement = $this->pdo->prepare($sql);

                    // bind value to the :id parameter
                    $statement->bindValue(':id', $request['id']);

                    //echo $sql; exit;

                } else {

                    $conditions = "";
                    $refinements = "";

                    // SKIP ID
                    //if(isset($request['attributes'])){$refinements.="message_attributes"." ILIKE "."'%".$request['attributes']."%' AND ";}
                    if(isset($request['body'])){$refinements.="message_body"." ILIKE "."'%".$request['body']."%' AND ";}
                    //if(isset($request['images'])){$refinements.="message_images"." ILIKE "."'%".$request['images']."%' AND ";}
                    if(isset($request['deleted'])){$refinements.="message_deleted"." = "."'".$request['deleted']."' AND ";}
                    //if(isset($request['profile'])){$refinements.="profile_id"." = "."'%".$request['profile']."%' AND ";}
                    if(isset($request['thread'])){$refinements.="thread_id"." = "."'".$request['thread']."' AND ";}

                    //echo $conditions . 'conditions1<br/>';
                    //echo $refinements . 'refinements1<br/>';
                    
                    $conditions.= " WHERE ";
                    $conditions.= $refinements;
                    $conditions.= " active = 1 ";
                    $conditions.= ' AND app_id = \'' . $request['app'] . '\' ';
                    $conditions.= " ORDER BY time_finished DESC ";
                    $subset = " OFFSET {$start}" . " LIMIT {$request['per']}";
                    $sql = "SELECT ";
                    $sql.= $columns;
                    $sql.= "FROM " . $table;
                    $sql.= $conditions;
                    $sql.= $subset;

                    //echo $conditions . 'conditions2<br/>';
                    //echo $refinements . 'refinements2<br/>';

                    //echo $sql; exit;
                    
                    //
                    $statement = $this->pdo->prepare($sql);

                }
                    
                // execute the statement
                $statement->execute();

                //
                $results = [];
                $total = $statement->rowCount();
                $pages = ceil($total/$request['per']); //
                //$current = 1; // current page
                //$limit = $result['limit'];
                //$max = $result['max'];

                //
                if($statement->rowCount() > 0) {

                    //
                    $data = array();
                
                    //
                    while($row = $statement->fetch(\PDO::FETCH_ASSOC)) {
        
                        //
                        $data[] = [

                            'id' => $row['message_id'],
                            'attributes' => json_decode($row['message_attributes']),
                            'body' => $row['message_body'],
                            'images' => json_decode($row['message_images']),
                            'deleted' => $row['message_deleted'],
                            'thread' => $row['thread_id'],
                            'profile' => $row['profile_id'],
                            'app' => $row['app_id'],
                            'when' => $row['time_finished'],
                            'updated' => $row['time_updated']

                        ];

                    }

                    $code = 200;
                    $message = "OK";

                } else {

                    //
                    $data = NULL;
                    $code = 204;
                    $message = "No Content";

                }

            } else {

                //
                $data[] = NULL;
                $code = 401;
                $message = "Forbidden - Valid token required";

            }

            $results = array(

                'status' => $code,
                'message' => $message,
                'metadata' => [
                    'page' => $request['page'],
                    'pages' => $pages,
                    'total' => $total
                ],
                'data' => $data,
                'log' => [
                    'process' => $process_id = $this->token->process_id(),
                    'event' => $event_id = $this->token->event_id($process_id)
                ]

            );

            //
            return $results;

        }

        //
        public function updateMessage($request) {

            //
            $domain = $request['domain'];
            $table = prefixed($domain);
            $id = $request['id'];

            //
            $set = "";

            // UPDATE OBJECT - SET
            if(isset($request['id'])){$set.= " message_id = :message_id ";}
            if(isset($request['attributes'])){$set.= " message_attributes = :message_attributes ";}
            if(isset($request['body'])){$set.= " message_body = :message_body ";}
            if(isset($request['images'])){$set.= " message_images = :message_images ";}
            if(isset($request['deleted'])){$set.= " message_deleted = :message_deleted ";}
            //
            $set = str_replace('  ',',',$set);

            // GET table name
            $condition = $table."_id = :id";
            $condition.= " RETURNING " . $table . "_id";

            // sql statement to update a row in the stock table
            $sql = "UPDATE {$domain} SET ";
            $sql.= $set;
            $sql.= " WHERE ";
            $sql.= $condition;

            //echo $sql; exit;

            $statement = $this->pdo->prepare($sql);
    
            // 
            if(isset($request['id'])){$statement->bindValue(':message_id', $request['id']);}
            if(isset($request['attributes'])){$statement->bindValue(':message_attributes', $request['attributes']);}
            if(isset($request['body'])){$statement->bindValue(':message_body', $request['body']);}
            if(isset($request['images'])){$statement->bindValue(':message_images', $request['images']);}
            if(isset($request['deleted'])){$statement->bindValue(':message_deleted', $request['deleted']);}
            
            $statement->bindValue(':id', $id);

            

            // update data in the database
            $statement->execute();

            $data = $statement->fetchAll();
            
            $data = $data[0]['message_id'];

            // return generated id
            return $data;

            // return the number of row affected
            //return $statement->rowCount();

        }

        //
        public function deleteMessage($request) {

            $id = $request['id'];
            $domain = $request['domain'];
            $column = prefixed($domain) . '_id';
            $sql = 'DELETE FROM ' . $domain . ' WHERE '.$column.' = :id';
            //echo $id; //exit
            //echo $column; //exit;
            //echo $domain; //exit;
            //echo $sql; //exit

            $statement = $this->pdo->prepare($sql);
            //$statement->bindParam(':column', $column);
            $statement->bindValue(':id', $id);
            $statement->execute();
            return $statement->rowCount();

        }

    }
    
?>