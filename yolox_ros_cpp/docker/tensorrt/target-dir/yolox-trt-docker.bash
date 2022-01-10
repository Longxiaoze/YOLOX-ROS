YOLOX_VERSION="0.1.1rc0"
MODEL="yolox_tiny"
SCRIPT_DIR="/workspace/ros2_ws/src/YOLOX-ROS/weights/tensorrt/trtexec"

source /opt/ros/foxy/setup.bash

mkdir -p ros2_ws/src
cd /workspace/ros2_ws/src
git clone https://github.com/Ar-Ray-code/YOLOX-ROS.git --recursive
cd /workspace/ros2_ws
colcon build --symlink-install --cmake-args -DYOLOX_USE_TENSORRT=ON -DYOLOX_USE_OPENVINO=OFF
source /workspace/ros2_ws/install/setup.bash

wget https://github.com/Megvii-BaseDetection/YOLOX/releases/download/$YOLOX_VERSION/$MODEL.onnx -P /workspace/ros2_ws/src/YOLOX-ROS/weights/onnx
/usr/src/tensorrt/bin/trtexec --onnx=$SCRIPT_DIR/../../onnx/$MODEL.onnx --saveEngine=$SCRIPT_DIR/$MODEL.trt --fp16 --verbose --workspace=100000

ros2 launch yolox_ros_cpp yolox_tensorrt.launch.py



exit 0