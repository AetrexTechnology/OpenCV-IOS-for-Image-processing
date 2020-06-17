import UIKit

class ViewController: UIViewController, OpenCVCamDelegate
{

    @IBOutlet weak var imageView: UIImageView!

    var openCVWrapper: OpenCVWrapper!

    var lastTimeSet: Double = 0


    override func viewDidLoad()
    {
        super.viewDidLoad()
        openCVWrapper = OpenCVWrapper()
        openCVWrapper.setDelegate(self)
        openCVWrapper.start()
    }

    func imageProcessed(_ image: UIImage)
    {
        DispatchQueue.main.async
        {
            self.imageView.image = image
        }
    }

    @IBAction func start(_ button: UIButton)
    {
        let showImage = true

        openCVWrapper.stop()
    }

    @IBAction func stop(_ button: UIButton)
    {
        openCVWrapper.stop()
    }
}

