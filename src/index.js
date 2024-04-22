exports.handler = async (event) => {
  console.log('my_event', event);

  // send it to SQS
  return 'Hello world';
};
