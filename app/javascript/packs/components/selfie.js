import Rails from "@rails/ujs";

const initSelfie = () => {
  const video = document.querySelector('.selfie-video');
  const photo = document.querySelector('.selfie-photo');
  const startbutton = document.querySelector('.selfie-startbutton');
  const canvas = document.createElement('canvas');

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

    startbutton.innerText = "✅";
    video.pause();

    Rails.ajax({
      url: "/selfies",
      type: "post",
      data: formData
    })
  }

  navigator.mediaDevices.getUserMedia({ video: true, audio: false })
    .then(function(stream) {
        video.srcObject = stream;
        video.play();
    })
    .catch(function(err) {
        console.log("An error occurred: " + err);
    });

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

  startbutton.addEventListener('click', (event) => {
      event.preventDefault();
      takePicture();
    });
}

export { initSelfie };
