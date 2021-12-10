// Generated by gencpp from file cam/Stop.msg
// DO NOT EDIT!


#ifndef CAM_MESSAGE_STOP_H
#define CAM_MESSAGE_STOP_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace cam
{
template <class ContainerAllocator>
struct Stop_
{
  typedef Stop_<ContainerAllocator> Type;

  Stop_()
    : flag(false)  {
    }
  Stop_(const ContainerAllocator& _alloc)
    : flag(false)  {
  (void)_alloc;
    }



   typedef uint8_t _flag_type;
  _flag_type flag;





  typedef boost::shared_ptr< ::cam::Stop_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::cam::Stop_<ContainerAllocator> const> ConstPtr;

}; // struct Stop_

typedef ::cam::Stop_<std::allocator<void> > Stop;

typedef boost::shared_ptr< ::cam::Stop > StopPtr;
typedef boost::shared_ptr< ::cam::Stop const> StopConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::cam::Stop_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::cam::Stop_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::cam::Stop_<ContainerAllocator1> & lhs, const ::cam::Stop_<ContainerAllocator2> & rhs)
{
  return lhs.flag == rhs.flag;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::cam::Stop_<ContainerAllocator1> & lhs, const ::cam::Stop_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace cam

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::cam::Stop_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::cam::Stop_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::cam::Stop_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::cam::Stop_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::cam::Stop_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::cam::Stop_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::cam::Stop_<ContainerAllocator> >
{
  static const char* value()
  {
    return "24842bc754e0f5cc982338eca1269251";
  }

  static const char* value(const ::cam::Stop_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x24842bc754e0f5ccULL;
  static const uint64_t static_value2 = 0x982338eca1269251ULL;
};

template<class ContainerAllocator>
struct DataType< ::cam::Stop_<ContainerAllocator> >
{
  static const char* value()
  {
    return "cam/Stop";
  }

  static const char* value(const ::cam::Stop_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::cam::Stop_<ContainerAllocator> >
{
  static const char* value()
  {
    return "bool flag\n"
;
  }

  static const char* value(const ::cam::Stop_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::cam::Stop_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.flag);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct Stop_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::cam::Stop_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::cam::Stop_<ContainerAllocator>& v)
  {
    s << indent << "flag: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.flag);
  }
};

} // namespace message_operations
} // namespace ros

#endif // CAM_MESSAGE_STOP_H