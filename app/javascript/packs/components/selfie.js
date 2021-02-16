import Rails from "@rails/ujs";

const initSelfie = () => {
  const video = document.querySelector('.selfie-video');
  const photo = document.querySelector('.selfie-photo');
  const startButton = document.querySelector('.selfie-btn.start');
  const flipButton = document.querySelector('.selfie-btn.flip');
  const canvas = document.createElement('canvas');

  let front = false;
  let width = 400;    // We will scale the photo width to this
  let height = 0;
  let streaming = false;

  const takePicture = async () => {
    var context = canvas.getContext('2d');
    canvas.width = width;
    canvas.height = height;
    context.drawImage(video, 0, 0, width, height);

    let data = await new Promise((resolve) => {
      canvas.toBlob(resolve, 'image/png');
    });

    const formData = new FormData();
    formData.append('selfie[photo]', data, 'selfie.png');
    formData.append('selfie[title]', `Picture taken on ${(new Date).toString()}`);

    startButton.innerText = "✅";
    video.pause();

    Rails.ajax({
      url: "/selfies",
      type: "post",
      data: formData
    })
  }

  const addStreamToVideo = () => {
    navigator.mediaDevices.getUserMedia({ video: { facingMode: (front ? "user" : "environment") }, audio: false })
      .then(function(stream) {
          video.srcObject = stream;
          video.play();
      })
      .catch(function(err) {
          console.log("An error occurred: " + err);
      });
  }

  addStreamToVideo();

  video.addEventListener('canplay', function(ev){
      if (!streaming) {
        height = video.videoHeight / (video.videoWidth/width);

        video.setAttribute('width', width);
        video.setAttribute('height', height);
        canvas.setAttribute('width', width);
        canvas.setAttribute('height', height);
        streaming = true;
      }
    }, false);

  startButton.addEventListener('click', (event) => {
    takePicture();
  });

  flipButton.addEventListener('click', (event) => {
   front = !front;
   addStreamToVideo();
  });

}

export { initSelfie };
