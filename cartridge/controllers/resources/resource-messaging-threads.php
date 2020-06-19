<?php

    //
    header('Content-Type: application/json');

    //
    use Messaging\Connection as Connection;
    use Messaging\Token as Token;
    use Messaging\Thread as Thread;

    // connect to the PostgreSQL database
    $pdo = Connection::get()->connect();

    // STEP 1. Receive passed variables / information
    if(isset($_REQUEST['app'])){$request['app'] = clean($_REQUEST['app']);}
    if(isset($_REQUEST['domain'])){$request['domain'] = clean($_REQUEST['domain']);}
    if(isset($_REQUEST['token'])){$request['token'] = clean($_REQUEST['token']);}

    // INITIATE DATA CLEANSE
    if(isset($_REQUEST['id'])){$request['id'] = clean($_REQUEST['id']);}
    if(isset($_REQUEST['attributes'])){$request['attributes'] = clean($_REQUEST['attributes']);}
    if(isset($_REQUEST['title'])){$request['title'] = clean($_REQUEST['title']);}
    if(isset($_REQUEST['participants'])){$request['participants'] = clean($_REQUEST['participants']);}
    if(isset($_REQUEST['preview'])){$request['preview'] = clean($_REQUEST['preview']);}
    if(isset($_REQUEST['profile'])){$request['profile'] = clean($_REQUEST['profile']);}   

    //
    switch ($_SERVER['REQUEST_METHOD']) {

        //
        case 'POST':

            try {

                // 
                $thread = new Thread($pdo);

                $thread_details = $thread->selectThreads($request);

                //
                if($thread_details['status']==204) {

                    // insert a stock into the stocks table
                    if(!isset($request['thread']) || empty($request['thread'])) {
                        
                        $request['id'] = $thread->insertThread($request);
                    
                    } else { 
                        
                        $request['id'] = $request['thread'];
                    
                    }
                
                }

                // insert a stock into the stocks table
                //$id = $thread->insertThread($request);

                //$request['id'] = $id;

                $results = $thread->selectThreads($request);

                $results = json_encode($results);
                
                //
                echo $results;
            
            } catch (\PDOException $e) {

                echo $e->getMessage();

            }

        break;

        //
        case 'GET':

            //
            if(isset($_REQUEST['per'])){$request['per'] = clean($_REQUEST['per']);}
            if(isset($_REQUEST['page'])){$request['page'] = clean($_REQUEST['page']);}
            if(isset($_REQUEST['limit'])){$request['limit'] = clean($_REQUEST['limit']);}        

            try {

                // 
                $thread = new Thread($pdo);

                // get all stocks data
                $results = $thread->selectThreads($request);

                $results = json_encode($results);

                echo $results;

            } catch (\PDOException $e) {

                echo $e->getMessage();

            }

        break;

        //
        case 'PUT':

            try {

                // 
                $thread = new Thread($pdo);
            
                // insert a stock into the stocks table
                $id = $thread->updateThread($request);

                $request['id'] = $id;

                $results = $thread->selectThreads($request);

                $results = json_encode($results);

                echo $results;
            
            } catch (\PDOException $e) {

                echo $e->getMessage();

            }

        break;

        //
        case 'DELETE':

            try {

                // 
                $thread = new Thread($pdo);
            
                // insert a stock into the stocks table
                $id = $thread->deleteThread($request);

                echo 'The record ' . $id . ' has been deleted';
            
            } catch (\PDOException $e) {

                echo $e->getMessage();

            }

        break;

    }

?>
