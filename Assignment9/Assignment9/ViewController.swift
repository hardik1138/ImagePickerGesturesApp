
import UIKit

class ViewController: UIViewController {

    private let SubView =  UIView()
    private let imgView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "img")
        iv.clipsToBounds = true
        
        return iv
    }()
    
    private let ImagePicker : UIImagePickerController = {
        let ip = UIImagePickerController()
        ip.allowsEditing = false
        return ip
    }()
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        view.addSubview(SubView)
        SubView.addSubview(imgView)
        SubView.frame = CGRect(x: (view.width - 200) / 2.0, y: (view.height - 300) / 2.0, width: 200, height: 300)
        imgView.frame = CGRect(x: 0, y: 0, width: 200, height: 300)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapview))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        SubView.addGestureRecognizer(tapGesture)
        ImagePicker.delegate = self
        
        let pinchGeture = UIPinchGestureRecognizer(target: self, action: #selector(didPinchview))
        view.addGestureRecognizer(pinchGeture)
        
        //rotation
        let rotationGeture = UIRotationGestureRecognizer(target: self, action: #selector(didRotationview))
        view.addGestureRecognizer(rotationGeture)
        
        //Swipe
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didLeftSwipeview))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didLeftSwipeview))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didLeftSwipeview))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didLeftSwipeview))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        
        //pan
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPanview))
        view.addGestureRecognizer(panGesture)
    }

}
extension ViewController :UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @objc private func didTapview(gesture:UITapGestureRecognizer){
        ImagePicker.sourceType = .photoLibrary
        DispatchQueue.main.async {
            self.present(self.ImagePicker,animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage{
            imgView.image = selectedImage
        }
        picker.dismiss(animated: true)
    }
    
    @objc private func didPinchview(gesture:UIPinchGestureRecognizer){
        SubView.transform = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
    }
    
    @objc private func didRotationview(gesture:UIRotationGestureRecognizer){
        SubView.transform = CGAffineTransform(rotationAngle: gesture.rotation)
        
    }
    @objc private func didLeftSwipeview(gesture:UISwipeGestureRecognizer){
        if gesture.direction == .left{
            UIView.animate(withDuration:0.5)
            {
                self.SubView.frame = CGRect(x: self.SubView.left - 40, y: self.SubView.top, width: 200, height: 200)
            }
        }else if gesture.direction == .right{
            UIView.animate(withDuration:0.5)
            {
                self.SubView.frame = CGRect(x: self.SubView.left + 40, y: self.SubView.top, width: 200, height: 200)
            }
        }else if gesture.direction == .up{
            UIView.animate(withDuration:0.5)
            {
                self.SubView.frame = CGRect(x: self.SubView.left, y: self.SubView.top - 40, width: 200, height: 200)
            }
        }else if gesture.direction == .down{
            UIView.animate(withDuration:0.5)
            {
                self.SubView.frame = CGRect(x: self.SubView.left , y: self.SubView.top + 40, width: 200, height: 200)
            }
        }
    }
    @objc private func didPanview(gesture:UIPanGestureRecognizer){
        let x  = gesture.location(in: view).x
       let y  = gesture.location(in: view).y

        SubView.center = CGPoint(x: x, y: y)
    }
}

