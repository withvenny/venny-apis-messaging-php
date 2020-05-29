<?php

    //
    header('Content-Type: application/json');

    //
    use Messaging\Connection as Connection;
    use Messaging\Token as Token;
    use Messaging\Message as Message;
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
    if(isset($_REQUEST['body'])){$request['body'] = clean($_REQUEST['body']);}		
    //if(isset($_REQUEST['images'])){$request['images'] = clean($_REQUEST['images']);}		
    if(isset($_REQUEST['deleted'])){$request['deleted'] = clean($_REQUEST['deleted']);}
    if(isset($_REQUEST['thread'])){$request['thread'] = clean($_REQUEST['thread']);}
    if(isset($_REQUEST['profile'])){$request['profile'] = clean($_REQUEST['profile']);}
    if(isset($_REQUEST['title'])){$request['title'] = clean($_REQUEST['title']);}
    if(isset($_REQUEST['participants'])){$request['participants'] = clean($_REQUEST['participants']);}
    if(isset($_REQUEST['preview'])){$request['preview'] = clean($_REQUEST['preview']);}
    if(isset($_REQUEST['profile'])){$request['profile'] = clean($_REQUEST['profile']);} 

    //
    if($_SERVER['REQUEST_METHOD']=='POST') {

        try {

            // 
            $message = new Message($pdo);
            $thread = new Thread($pdo);
            $token = new Token($pdo);

            //
            $request['domain'] = 'threads';

            // get person ID's details
            $thread_details = $thread->selectThreads($request);

            //
            $request['thread'] = $thread_details['data'][0]['id'];
            //echo json_encode($request); exit;

            $request['domain'] = 'messages';

            // insert a stock into the stocks table
            $request['id'] = $message->insertMessage($request);

            //echo json_encode($request); exit;

            // get person ID's details
            $message_details = $message->selectMessages($request);

            //echo json_encode($user_details); exit;

            //echo json_encode($profile_details); exit;

            //
            $results['status'] = 200;
            $results['message'] = 'SUCCESSFUL';

            //
            //$data = array_push(...$person_details['data'],...$user_details['data'],...$profile_details['data']);
            //$results['data']=$data;

            $results['data']=NULL;
            $results['data']['thread']=$thread_details['data'];
            $results['data']['message']=$message_details['data'];

            $results['log'] = [
                'process' => $process_id = $token->process_id(),
                'event' => $token->event_id($process_id)
            ];

            //
            $results = json_encode($results);

            echo $results;
        
        } catch (\PDOException $e) {

            echo $e->getMessage();

        }

    }

?>
